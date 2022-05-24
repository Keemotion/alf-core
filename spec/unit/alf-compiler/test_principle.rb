require 'compiler_helper'
module Alf
  describe Compiler, "the overall principle" do

    # This is a compiler dedicated to specific adapters, e.g. SQL
    class DedicatedCompiler < Compiler

      def supports_reuse?
        true
      end

      def reuse(plan, compiled)
        compiled
      end

      def on_project(plan, expr, compiled)
        DedicatedCog.new(expr, self, [compiled])
      end

      def on_sort(plan, expr, compiled)
        Engine::Sort.new(compiled, expr.ordering)
      end

      def on_page(plan, expr, compiled)
        compiled = plan.recompile(compiled){|p|
          p.sort(expr.operand, expr.ordering)
        }
        DedicatedCog.new(expr, self, [compiled])
      end

      def on_ungroup(plan, expr, compiled)
        raise NotSupportedError
      end

      def on_union(plan, expr, left, right)
        DedicatedCog.new(expr, self, [left, right])
      end

    end # class DedicatedCompiler

    # This is the class supposed to be served by an adapter.
    # It returns self on to_cog and has the dedicated compiler.
    class DedicatedCog
      include Engine::Cog

      def initialize(expr, compiler, operands = nil)
        super(expr, compiler)
        @operands = operands
      end
      attr_reader :operands

      def left
        unless operands && operands.size == 2
          raise "Unexpected operands `#{operands.inspect}`"
        end
        operands.first
      end

      def right
        unless operands && operands.size == 2
          raise "Unexpected operands `#{operands.inspect}`"
        end
        operands.last
      end

      def operand
        unless operands && operands.size == 1
          raise "Unexpected operands `#{operands.inspect}`"
        end
        operands.first
      end

    end # class DedicatedCog

    subject{ default.call(expr) }

    let(:cog){
      DedicatedCog.new(nil, dedicated)
    }

    let(:cog2){
      DedicatedCog.new(nil, dedicated)
    }

    let(:default){
      Compiler::Default.new
    }

    let(:dedicated){
      DedicatedCompiler.new
    }

    context 'on a direct cog-proxied operand' do
      # the first compiler takes care of compiling the stuff, by simple
      # delegation to to_cog of the operand

      let(:expr){
        an_operand(cog)
      }

      it{ should be(cog) }

      it 'should have expected compiler' do
        expect(subject.compiler).to be(dedicated)
      end
    end

    context 'on a supported operator' do
      # the first compiler compiles the leaf.
      # the second compiler compiles the projection.

      let(:expr){
        project(an_operand(cog), [:a])
      }

      it{ should be_a(DedicatedCog) }

      it 'should have correct expr' do
        expect(subject.expr).to be(expr)
      end

      it 'should have expected compiler' do
        expect(subject.compiler).to be(dedicated)
      end

      it 'should have correct operand' do
        expect(subject.operand).to be(cog)
        expect(subject.operand.compiler).to be(dedicated)
      end
    end

    context 'on a dyadic supported operator' do
      # the first compiler compiles both leafs.
      # the second compiler compiles the union.

      let(:expr){
        union(an_operand(cog), an_operand(cog2))
      }

      it{ should be_a(DedicatedCog) }

      it 'should have correct expr' do
        expect(subject.expr).to be(expr)
      end

      it 'should have correct operands' do
        expect(subject.operands).to eq([cog, cog2])
      end

      it 'should have expected compiler' do
        expect(subject.compiler).to be(dedicated)
      end
    end

    context 'on an operator requiring compiling sub-expressions' do

      let(:expr){
        page(an_operand(cog), [:name, :asc], 2)
      }

      it{ should be_a(DedicatedCog) }

      it 'has the sort as sub-cog' do
        expect(subject.operand).to be_kind_of(Engine::Sort)
      end

      it 'has the cog as sub-sub operand' do
        expect(subject.operand.operand).to be(cog)
      end

      it 'should have expected compiler' do
        expect(subject.compiler).to be(dedicated)
      end
    end

    context 'on an unsupported operator' do
      # the first compiler compiles the leaf.
      # the second compiler fails at compiling the projection.
      # the first compiler compiles the projection.

      let(:expr){
        rename(an_operand(cog), :a => :b)
      }

      it{ should be_a(Engine::Rename) }

      it 'should have the cog as operand' do
        expect(subject.operand).to be(cog)
      end

      it 'should have expected compiler' do
        expect(subject.compiler).to be(default)
      end
    end

    context 'on a partly supported operator' do
      # the first compiler compiles the leaf.
      # the second compiler fails at compiling the unwrap and fallsback.
      # the first compiler compiles the unwrap.

      let(:expr){
        unwrap(an_operand(cog), :a)
      }

      it{ should be_a(Engine::Unwrap) }

      it 'should have the cog as operand' do
        expect(subject.operand).to be(cog)
      end

      it 'should have expected compilers' do
        expect(subject.compiler).to be(default)
      end
    end

    context 'on a partly supported operator through a NotSupportedError' do
      # the first compiler compiles the leaf.
      # the second compiler fails at compiling the ungroup and fallsback.
      # the first compiler compiles the ungroup.

      let(:expr){
        ungroup(an_operand(cog), :a)
      }

      it{ should be_a(Engine::Ungroup) }

      it 'should have the cog as operand' do
        expect(subject.operand).to be(cog)
      end

      it 'should have expected compilers' do
        expect(subject.compiler).to be(default)
      end
    end

    context 'on a doubly supported operator' do
      # the first compiler compiles the leaf.
      # the second compiler compiles the first projection.
      # the second compiler compiles the second projection.

      let(:subexpr){
        project(an_operand(cog), [:a])
      }

      let(:expr){
        project(subexpr)
      }

      it{ should be_a(DedicatedCog) }

      it 'should have correct traceability' do
        expect(subject.expr).to be(expr)
      end

      it 'should have expected compiler' do
        expect(subject.compiler).to be(dedicated)
      end

      it 'should have correct sub-cog' do
        expect(subject.operand).to be_kind_of(DedicatedCog)
        expect(subject.operand.expr).to be(subexpr)
        expect(subject.operand.compiler).to be(dedicated)
      end

      it 'should have correct sub-sub-cog' do
        expect(subject.operand.operand).to be(cog)
        expect(subject.operand.operand.compiler).to be(dedicated)
      end
    end

    context 'on a dyadic operator compiled by two different compilers' do
      # the first compiler compiles the left leaf and the projection.
      # the second compiler compiles the right leaf and the projection.
      # the this compiler compiles the union.

      let(:expr){
        join(project(an_operand(left), [:a]), project(an_operand(right), [:a]))
      }

      let(:compilo1){
        DedicatedCompiler.new
      }

      let(:compilo2){
        DedicatedCompiler.new
      }

      let(:left){
        DedicatedCog.new(nil, compilo1)
      }

      let(:right){
        DedicatedCog.new(nil, compilo2)
      }

      let(:default){
        Compiler::Default.new
      }

      it{ should be_a(Engine::Join) }

      it 'should have correct expr' do
        expect(subject.expr).to be(expr)
      end

      it 'should have correct sub-cogs' do
        expect(subject.left).to be_kind_of(DedicatedCog)
        expect(subject.right).to be_kind_of(DedicatedCog)
      end

      it 'should have expected compilers' do
        expect(subject.compiler).to be(default)
        expect(subject.left.compiler).to be(compilo1)
        expect(subject.right.compiler).to be(compilo2)
      end
    end

    context 'on expressions where reuse is possible' do
      let(:expr){
        reused = project(an_operand(cog), [:a])
        union(reused, reused)
      }

      it{ should be_a(DedicatedCog) }

      it 'should reuse the compilation result' do
        expect(subject.left).to be(subject.right)
      end
    end

  end
end

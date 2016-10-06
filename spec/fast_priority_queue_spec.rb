require "spec_helper"

describe FastPriorityQueue do
  let(:fpq) { FastPriorityQueue.new }
  it "has a version number" do
    expect(FastPriorityQueue::VERSION).not_to be nil
  end

  describe "#initialize" do
    it "inits with length 0" do
      expect(fpq.length).to eq(0)
    end
  end

  describe "#add" do
    it "returns nil" do
      expect(fpq.add(1)).to eq(nil)
    end

    it "increases size" do
      expect { fpq.add("xxx") }.to change{fpq.length}.from(0).to(1)
      expect { fpq.add("yyy") }.to change{fpq.length}.from(1).to(2)
      expect { fpq.add("aaa") }.to change{fpq.length}.from(2).to(3)
    end
  end

  describe "#top" do
    context "with empty queue" do
      it "returns nil" do
        expect(fpq.top).to be_nil
      end
    end

    context "with multiple elements" do
      it "always return the correct top element" do
        arr = 1000.times.map { rand(100) }
        curr_min = arr[0]
        arr.each do |x|
          curr_min = [curr_min,x].min
          fpq.add x
          expect(fpq.top).to eq(curr_min)
        end
      end
    end

  end

  describe "#pop" do
    context "with empty queue" do
      it "returns nil" do
        expect(fpq.pop).to be_nil
      end
    end

    context "with 1 element" do
      it "returns the element" do
        a = 234
        fpq.add a
        expect(fpq.pop).to eq(a)
      end
    end

    context "with multiple elements" do

      it "decrease the size of the queue" do
        fpq.add 1
        fpq.add 2
        expect { fpq.pop }.to change{fpq.length}.from(2).to(1)
        expect { fpq.pop }.to change{fpq.length}.from(1).to(0)
        expect { fpq.pop }.to_not change { fpq.length }
        expect { fpq.pop }.to_not change { fpq.length }
      end

      it "return the top element" do
        1000.times.map { fpq.add rand(100) }
        arr = []
        while fpq.length > 0
          arr << fpq.pop
        end
        expect( (1...arr.length).all? { |i| arr[i] >= arr[i-1] } ).to eq(true)
      end
    end
  end

  describe "#empty?" do
    context "with empty queue" do
      it "return true" do
        expect(fpq.empty?).to eq(true)
      end
    end


    context "with multiple elements" do

      it "return false" do
        fpq.add 1
        expect(fpq.empty?).to eq(false)
        fpq.add 2
        expect(fpq.empty?).to eq(false)
        fpq.add 3
        expect(fpq.empty?).to eq(false)
      end

    end
  end

end

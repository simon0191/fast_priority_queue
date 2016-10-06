require "spec_helper"

describe FastPriorityQueue do
  let(:fpq) { FastPriorityQueue.new }
  it "has a version number" do
    expect(FastPriorityQueue::VERSION).not_to be nil
  end

  it "defines hello_world method in rust" do
    expect(fpq.hello_world).to eq('hello world')
  end

  describe "#initialize" do
    it "inits with length 0" do
      expect(fpq.length).to eq(0)
    end
  end

  describe "#compare" do
    it "compares a and b" do
      expect(fpq.compare(1,200)).to be_negative
      expect(fpq.compare(1000,1)).to be_positive
      expect(fpq.compare(1000,1000)).to eq(0)
    end

    context "with custom cmp function" do
      let(:fpq) { FastPriorityQueue.new { |a,b| b <=> a } }

      it "compares a and b" do
        expect(fpq.compare(1,200)).to be_positive
        expect(fpq.compare(1000,1)).to be_negative
        expect(fpq.compare(1000,1000)).to eq(0)
      end
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
        arr = 100.times.map { rand(100) }
        curr_min = arr[0]
        arr.each do |x|
          curr_min = [curr_min,x].min
          fpq.add x
          expect(fpq.top).to eq(curr_min)
        end
      end
    end

  end

end

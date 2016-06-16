require 'spec_helper'

describe ConfigFreak do

  describe ".expand" do

    let(:output) { ConfigFreak.expand(input) }

    context "with a simple config Hash" do

      let(:input) do
        {
          "author" => {
            "name" => "Mike"
          }
        }
      end

      it "returns the input" do
        expect(output).to eql(input)
      end

    end

    context "with reference" do

      let(:input) do
        {
          "x" => 42,
          "y" => "{{x}}"
        }
      end

      it "expands the reference" do
        expect(output["y"]).to eql(42)
      end

    end

  end

end

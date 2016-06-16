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

  end

end

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

    context "with complex reference" do

      let(:input) do
        {
          "vars" => {
            "author" => {
              "name" => "Mike"
            }
          },
          "foo" => "{{vars.author.name}}"
        }
      end

      it "expands the reference" do
        expect(output["foo"]).to eql("Mike")
      end

    end

    context "with reference in nested object" do

      let(:input) do
        {
          "vars" => {
            "author" => {
              "name" => "Mike"
            }
          },
          "foo" => {
            "bar" => "{{vars.author.name}}"
          }
        }
      end

      it "expands the reference" do
        expect(output["foo"]["bar"]).to eql("Mike")
      end

    end

    context "with reference embedded in a String" do

      let(:input) do
        {
          "size" => 42,
          "desc" => "Size {{size}}"
        }
      end

      it "expands the reference" do
        expect(output["desc"]).to eql("Size 42")
      end

    end

  end

end

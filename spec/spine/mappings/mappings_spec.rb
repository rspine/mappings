require 'ostruct'
require 'date'
require 'spine/mappings'

module Spine
  module Mappings
    describe Mappings do
      subject { Mappings }

      it 'defines empty mapper' do
        subject.define(:test) {}
        expect(subject.find(:test)).to be
      end

      it 'maps data by coping attribute with same name' do
        subject.define :test do
          any :id
        end

        data = OpenStruct.new(id: 1)
        mapped = subject.find(:test).map(data)

        expect(mapped[:id]).to eq(1)
      end

      it 'maps data by coping attribute with different name' do
        subject.define :test do
          any :value, from: :test_value
        end

        data = OpenStruct.new(test_value: 1)
        mapped = subject.find(:test).map(data)

        expect(mapped[:value]).to eq(1)
      end

      it 'maps data by coping attribute from closure' do
        subject.define :test do
          any(:value) { |source| source.test_value }
        end

        data = OpenStruct.new(test_value: 1)
        mapped = subject.find(:test).map(data)

        expect(mapped[:value]).to eq(1)
      end

      it 'maps empty data as nil' do
        subject.define(:test) do
          any :value
        end

        data = OpenStruct.new(value: nil)
        mapped = subject.find(:test).map(data)

        expect(mapped[:value]).to eq(nil)
      end

      it 'maps data with empty mapper' do
        subject.define(:test) {}
        expect(subject.find(:test).map(Object.new)).to eq({})
      end

      it 'maps hash to hash' do
        subject.define(:test) do
          any :x, from: :y
        end

        expect(subject.find(:test).map(y: 1)).to eq(x: 1)
      end

      describe 'when using interceptors' do
        it 'maps data by converting it to string' do
          subject.define :test do
            string :value
          end

          data = OpenStruct.new(value: 1)
          mapped = subject.find(:test).map(data)

          expect(mapped[:value]).to eq('1')
        end

        it 'maps data by converting it to integer' do
          subject.define :test do
            integer :value
          end

          data = OpenStruct.new(value: "1")
          mapped = subject.find(:test).map(data)

          expect(mapped[:value]).to eq(1)
        end

        it 'maps nil data when nullable' do
          subject.define :test do
            integer :value, nullable: true
          end

          data = OpenStruct.new(value: nil)
          mapped = subject.find(:test).map(data)

          expect(mapped[:value]).to eq(nil)
        end

        it 'maps nil data to default' do
          subject.define :test do
            integer :value, default: 1
          end

          data = OpenStruct.new(value: nil)
          mapped = subject.find(:test).map(data)

          expect(mapped[:value]).to eq(1)
        end

        it 'maps data by converting it to decimal' do
          subject.define :test do
            decimal :value
          end

          data = OpenStruct.new(value: "1.5")
          mapped = subject.find(:test).map(data)

          expect(mapped[:value]).to eq(1.5)
        end

        it 'maps data by converting it to boolean' do
          subject.define :test do
            boolean :value
          end

          data = OpenStruct.new(value: '1')
          mapped = subject.find(:test).map(data)

          expect(mapped[:value]).to eq(true)
        end

        it 'maps data by converting it to date' do
          subject.define :test do
            date :value
          end

          value = Time.now
          data = OpenStruct.new(value: value)
          mapped = subject.find(:test).map(data)

          expect(mapped[:value]).to eq(value.to_date.iso8601)
        end

        it 'maps data by converting it to date time' do
          subject.define :test do
            datetime :value
          end

          value = Time.now
          data = OpenStruct.new(value: value)
          mapped = subject.find(:test).map(data)

          expect(mapped[:value]).to eq(value.to_datetime.iso8601)
        end

        it 'maps data by converting it to timestamp' do
          subject.define :test do
            timestamp :value
          end

          value = Time.now
          data = OpenStruct.new(value: value)
          mapped = subject.find(:test).map(data)

          expect(mapped[:value]).to eq(value.to_datetime.iso8601(3))
        end
      end

      describe 'when using other mappings' do
        it 'maps data by converting it by other mapper' do
          subject.define :nested_object do
            any :nested_value
          end
          subject.define(:test) do
            nested_object :value
          end

          data = double(value: double(nested_value: 1))
          mapped = subject.find(:test).map(data)

          expect(mapped[:value][:nested_value])
            .to eq(data.value.nested_value)
        end

        it 'maps data by converting it by other complex mapper' do
          subject.define :nested_object do
            any :nested_value, from: :test_value
          end
          subject.define :test do
            nested_object :value
          end

          data = double(value: double(test_value: 1))
          mapped = subject.find(:test).map(data)

          expect(mapped[:value][:nested_value])
            .to eq(data.value.test_value)
        end

        it 'raises error when nested mapper is not defined' do
          expect {
            subject.define :test do
              not_defined_nested_object :value
            end
            }.to raise_error(KeyError)
        end
      end

      describe 'when using mapping strategies' do
        it 'maps using strict strategy' do
          subject.define(:test) do
            any :x
          end

          expect(subject.find(:test).map(y: 1).keys).to include(:x)
        end

        it 'maps using compact strategy' do
          subject.define(:test) do
            any :x
          end

          source = { y: 1 }
          mapped = subject.find(:test).map(source, strategy: :compact)
          expect(mapped.keys).not_to include(:x)
        end
      end

      describe 'when mapping nested objects' do
        it 'maps nested hash' do
          subject.define(:test) do
            nested :x do
              any :y
            end
          end

          source = OpenStruct.new(x: OpenStruct.new(y: 1))
          mapped = subject.find(:test).map(source)
          expect(mapped[:x][:y]).to eq(source.x.y)
        end

        it 'maps nested object' do
          subject.define(:test) do
            nested :x do
              any :y
            end
          end

          source = { x: { y: 1 } }
          mapped = subject.find(:test).map(source)
          expect(mapped[:x][:y]).to eq(source[:x][:y])
        end
      end
    end
  end
end

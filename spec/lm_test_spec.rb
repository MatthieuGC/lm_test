require 'lm_test'
require 'json'

RSpec.describe LmTest do
  context 'Created file' do
    csv_file_name     = LmTest::Convert.to_csv('sample1.json')
    json_file_content = File.read('sample1.json')

    it 'CSV lines number (-1 for headers) == JSON file objects number' do
      csv_lines_number = File.readlines(csv_file_name).count - 1 # do not count headers which are JSON keys equivalents
      expect(csv_lines_number).to be == JSON.parse(json_file_content).count
    end
  end
end

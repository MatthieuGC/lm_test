require 'json'
require 'csv'

module LmTest
  class Convert

    def self.to_csv(file_path)
      content     = File.read file_path
      parsed_json = JSON.parse(content)

      # Use ; separator to be well displayed on EXCEL
      csv_text = CSV.generate(col_sep: ';', force_quotes: '"') do |csv|
        csv << define_headers(parsed_json)

        parsed_json.each do |object|
          csv << define_values(object)
        end
      end

      file_name = "[MatthieuGC]_LiveMentor_Test_Result_#{Time.now.strftime('%Y%m%d%H%M%S')}.csv"
      File.open(file_name, 'w') do |f|
        f.write csv_text
      end

      puts "This CSV file has been created : #{file_name}"
      return file_name
    rescue JSON::ParserError
      STDERR.puts(%q(The given file doesn't contain JSON or is corrupted.))
      exit(false)
    end

    private

    # Use the first object to define CSV headers with his keys
    # @param json the parsed json
    # @return Array
    def self.define_headers(json)
      json.first.each_with_object([]) do |(k,v), array|
        rec_keys(array, k, v)
      end
    end

    # Define values for each objects
    # @param object the current json object to extract values
    # @return Array
    def self.define_values(object)
      object.each_with_object([]) do |(k,v), array|
        rec_values(array, v)
      end
    end

    # Recursively build the CSV header for nested objects
    # @param keys the array containing the CSV headers made from JSON keys
    # @param key_path the current state of the final header in construction
    # @param value the current key value used to check if there is still a nested object
    # @return Array
    def self.rec_keys(keys, key_path, value)
     if value.respond_to?(:values)
       value.each { |k, v| rec_keys(keys, "#{key_path}.#{k}", v) }
     else
       keys << key_path
     end
     keys
    end

    # Recursively search the value for nested objects keys
    # @param values the array containing the final values for each objects
    # @param value the current value checked to know if it's still an object to parse
    # @return Array
    def self.rec_values(values, value)
     if value.respond_to?(:values)
       value.each { |_, v| rec_values(values, v) }
     elsif value.is_a? Array
       values << value.join(",")
     else
       values << value
     end
     values
    end

  end
end

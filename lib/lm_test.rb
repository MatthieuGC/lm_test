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

    def self.define_headers(json)
      json.first.each_with_object([]) do |(k,v), array|
        rec_keys(array, k, v)
      end
    end

    def self.define_values(object)
      object.each_with_object([]) do |(k,v), array|
        rec_values(array, v)
      end
    end

    def self.rec_keys(keys, key_path, value)
     if value.respond_to?(:values)
       value.each { |k, v| rec_keys(keys, "#{key_path}.#{k}", v) }
     else
       keys << key_path
     end
     keys
    end

    def self.rec_values(values, value)
     if value.respond_to?(:values)
       value.each { |k, v| rec_values(values, v) }
     elsif value.is_a? Array
       values << value.join(",")
     else
       values << value
     end
     values
    end

  end
end

class DataSanitizer
  def initialize(data)
    @data = data
    @sanitized_data = remove_unidentified_keys
  end

  attr_reader :sanitized_data

  private

  def remove_unidentified_keys
    @data.reject{|key, value| !Package.attribute_names.member?(key.to_s)}
  end
end

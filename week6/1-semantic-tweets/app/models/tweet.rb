class Tweet
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON

  attr_accessor :text, :id, :html, :analysis_data

  def attributes
    {'id' => @id, 'text' => @text}
  end
end

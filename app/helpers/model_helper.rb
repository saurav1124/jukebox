module ModelHelper
  
  UNIQUE_KEY_CHARS = (0...9).map{|i|i.to_s}.push(('a'...'z').map{|c| c}).push((0...9).map{|i|i.to_s}).flatten
  UNIQUE_KEY_CHARS_LEN = 36
  
  def gen_unique_key_for_model(size)
    return (0...size).map{ ModelHelper::UNIQUE_KEY_CHARS[rand(46)] }.join
  end
  
end

module JB
  class MediaLoader
    def self.load(user_id, folder)
      puts "Loading media content from '" + folder + "'"
      tf = DateTime.now
      cnt = 0
      Dir.foreach(folder) do |item|
        next if item == '.' or item == '..' or item == '.DS_Store'
        # do work on real items
        track = Track.new
        track.user_id = user_id
        track.media = File.new(folder + "/" + item)
        track.save!
        cnt = cnt + 1
      end
      time = (DateTime.now.to_i-tf.to_i).to_i
      puts "Loaded " + cnt.to_s + " tracks in " + time.to_s + " seconds"
    end
  end
end

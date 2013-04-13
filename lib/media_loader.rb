module JB
  class MediaLoader
    def self.load(user_id, folder)
      puts "Loading media content from '" + folder + "'"
      tf = DateTime.now
      cnt = 0
      Dir.foreach(folder) do |item|
        next if item == '.' or item == '..' or item == '.DS_Store'
        if !File.directory?(folder + "/" + item)
          # do work on real items
          puts "   -- " + item
          track = Track.new
          track.user_id = user_id
          track.media = File.new(folder + "/" + item)
          track.save!
          cnt = cnt + 1
        end
      end
      if cnt > 0
        time = (DateTime.now.to_i-tf.to_i).to_i
        puts "      Loaded " + cnt.to_s + " tracks in " + time.to_s + " seconds"
      end
      Dir.foreach(folder) do |item|
        next if item == '.' or item == '..' or item == '.DS_Store'
        if File.directory?(folder + "/" + item)
          JB::MediaLoader.load(user_id, folder + "/" + item)
        end
      end
    end
  end
end

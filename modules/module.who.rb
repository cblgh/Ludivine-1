#!/bin/env ruby
# encoding: utf-8

#: Ask me about other users.

class Answer

    def is

        username = @message.split(" ")[2].lstrip.rstrip

        @memory.connect()
        thoughts = @memory.load(username).shuffle

        definition = ""
        twitter = ""
        collaborations = 0
        collaborationsString = ""
        location = ""

        thoughts.each do |known|
            if known[1] == username then definition = known[2] end
            if known[0] == username && known[1] == "my twitter" then twitter   = "This user's Twitter is <https://twitter.com/"+known[2]+"|@"+known[2]+">. " end
            if known[0] == username && known[1] == "my location" then location = "Currently located in *"+known[2]+"*. " end
            if known[0] == username then collaborations += 1 end
        end

        if collaborations > 0
            collaborationsString = "\n*"+username.capitalize+"* has added *#{collaborations} entries* to my memory. "
        end

        if definition == "" then return "I do not know *#{username}*." end

        return "*"+username.capitalize+"* is "+definition+". \n"+location+twitter+collaborationsString
    end

    def am

        @memory.connect()
        thoughts = @memory.load(@username).shuffle

        thoughts.each do |known|
            if known[1] != @username then next end
            return "*You* are "+known[2]+"."
        end

        return "I do not know you."

    end

end
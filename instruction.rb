#The following script opens a new textfile in "write" mode  and then writes
#"Hello file!" to it:

fname = "sample.txt" somefile = File.open(fname, "w") somefile.puts "Hello
file!" somefile.close

# This also works:

somefile = File.open("sample.txt", "w") somefile.puts "Hello file!"
somefile.close

# next line invokes the File class method open,  which requires us to pass it
# two arguments: 1)  the filename, represented by a String,  and 2) the
# read/write mode. As you might guess,  "w" stands for write.

# Warning: Using "w" mode on an existing file will erase the contents of that
# file.  If you want to append to an existing file, use "a" as the second
# argument.

# The File class has its own puts method. But this one prints to the file
# instead of to the screen. You can also use write, which does not include a
# newline character at the end of the string. The close method finishes the
# writing process and prevents any further data operations on the file (though
# you can reopen it again).

# File.open vs open

require "open-uri"

remote_base_url = "http://en.wikipedia.org/wiki" remote_page_name =
"Ada_Lovelace" remote_full_url = remote_base_url + "/" + remote_page_name

remote_data = open(remote_full_url).read my_local_file = open("my-downloaded-
page.html", "w")

my_local_file.write(remote_data) my_local_file.close

# Notice how we didn't have to invoke the use of the File class. I purposefully
# omitted it then because I wanted to reduce the number of unfamiliar words and
# conventions in the introduction. Like puts, open is handled by the Kernel class.
# In this lesson, I've explicitly invoked it as a method of the File class just to
# make it more obvious that we're dealing with a local file rather than an input
# stream from a webpage.

remote_data = open(remote_full_url).read my_local_file = File.open("my-
downloaded-page.html", "w")

# Block notation

# Instead of assigning a file handle to a variable, like so:

somefile = File.open("sample.txt", "w")
somefile.puts "Hello file!"
somefile.close

# You can use the block convention with File.open:

# File.open("sample.txt", "w"){ |somefile| somefile.puts "Hello file!"}
# Reading a file uses the same File.open method as before. However, the second argument is an "r" instead of "w".
# After the file is opened, you can use a variety of methods to read its content. The most obviously-named method is read, which grabs all the file's contents:

file = File.open("sample.txt", "r")
contents = file.read
puts contents   #=> Lorem ipsum etc.

contents = file.read
puts contents   #=> ""

# Every read operation begins where the last read operation ended. In the case where we've read the entire file (by not passing in a number), the second read call has nothing left to read.
# example of read using the block format

contents = File.open("sample.txt", "r"){ |file| file.read }
puts contents

# Using readline and readlines

# When dealing with delimited files, such as comma-delimited text files, it's more convenient to read the file line by line. The readlines method can draw in all the content and automatically parse it as an array, splitting the file contents by the line breaks.

File.open("sample.txt").readlines.each do |line|
   puts line
end
# The method readline on the other hand, reads a singular line. Again, each read operation moves the file handle forward in the file. If you keep calling readline until you hit the end of the file and then call it again, you'll get an "end of file" error.

# The File class (more specifically, the IO class that File inherits from) contains the eof? method, which returns true if there is no more data in the file to read.

# The readline method is often used in conjunction with while or unless:


file = File.open("sample.txt", 'r')
while !file.eof?
   line = file.readline
   puts line
end

# The readline method seems to require more upkeep than readlines. So why use it when you plan on reading an entire file?

# Because the latter loads the entire file at once into memory. For most files under a few dozen megabytes, that's probably manageable on your home computer. But this is not good practice if the program is running on a computer that is serving multiple users, especially if the file is massive.

# The readline method may require a couple more lines of code, but it's more efficient in most scenarios when extracting something from each line; you aren't operating on the entire file contents at once, and you don't need to store the entirety of each line either.

# eof? → true or false
# Returns true if ios is at end of file that means there are no more data to read. The stream must be opened for reading or an IOError will be raised.

# f = File.new("testfile")
# dummy = f.readlines
# f.eof   #=> true



Bonus Exercise: Print only Hamlet's lines

Now that hamlet.txt is on your hard drive, open it again but this time, print only the lines by Hamlet.

If you open up the file, this is what it looks like (Hamlet's speech is highlighted in blue):

  Ham. Do not believe it.
  Ros. Believe what?
  Ham. That I can keep your counsel, and not mine own. Besides, to be
    demanded of a sponge, what replication should be made by the son
    of a king?
  Ros. Take you me for a sponge, my lord?
  Ham. Ay, sir; that soaks up the King's countenance, his rewards,  
    his authorities. But such officers do the King best service in
    the end. He keeps them, like an ape, in the corner of his jaw;
    first mouth'd, to be last Swallowed. When he needs what you have
    glean'd, it is but squeezing you and, sponge, you shall be dry
    again.
  Ros. I understand you not, my lord.
  Ham. I am glad of it. A knavish speech sleeps in a foolish ear.   
Note that each speaker's name is abbreviated to a few letters and a period. If the speaker's dialogue is longer than a single line, each successive line is indented four spaces.

When someone new speaks, his/her name is indented two spaces in. Also, dialogue ends if there is a blank line.

Hint: I don't think it's possible to do this without a regular expression. If you've been following this book linearly, then you may not know about regexes. They're a way to match patterns of text – such as, any string that has more than five consecutive vowels – rather than just literal characters. They're so useful that it's worth skipping ahead to them; you don't even need to program to use them.

There are several regexes that would work, but this one will suffice:

/^  [A-Z]/
Note that there are two spaces after the caret symbol ^. The caret symbol specifies that we want a pattern that starts with the beginning of the line. So when this regex is passed into the match method, it will match any line that begins with two spaces and a capitalized letter. Sample usage:


lines = ["Hello world", "  How are you?", "*Fine*, thank you!.", "  OK then."]   
lines.each do |line|
   puts line if line.match(/^  [A-Z]/)
end
The output:

  How are you?
  OK then.
One more hint: match also has an annoying "feature" in which any string passed into it is converted into a regex pattern. So if you wanted to match, say, "Ham.", you would need to escape the period: "Ham\.". The period, in regex syntax, stands for any character (including an empty space). Thus:


if "Honey Ham is my favorite".match("Ham.")
   puts "Hey, I just wanted to match 'Ham.' Ham with a dot!"
end
#=> Hey, I just wanted to match 'Ham.' Ham with a dot!
OK, last hint: you might find the string's strip method to be useful.

Solution

This solution uses match two times:

To match "Ham\." – again, we need to escape the dot with a backslash since the string is converted to a regex by match
To match the regex /^ [A-Z]/
We're also interested in blank lines, which are any lines in which this is the case:

line.strip.empty? == true
Remember that strip removes all consecutive whitespace from the beginning and end of a line.

When a given line matches "Ham\.", we know that it must be the beginning of some Hamlet dialogue (to my knowledge, Hamlet does not contain any dialogue in which there is the one-word sentence, "Ham.")

Once that criteria has been met, than any line that matches the given regex /^ [A-Z]/ must be a line in which someone new speaks. Or, if a line is blank, then also marks the end of Hamlet's speech. Therefore, we print every line from "Ham." on until the regex is matched or there is a blank line.


is_hamlet_speaking = false
File.open("hamlet.txt", "r") do |file|
   file.readlines.each do |line|

      if is_hamlet_speaking == true && ( line.match(/^  [A-Z]/) || line.strip.empty? )
        is_hamlet_speaking = false
      end

      is_hamlet_speaking = true if line.match("Ham\.")

      puts line if is_hamlet_speaking == true
   end   
end
This script almost gets it:

Ham. Methinks it is like a weasel. 
Ham. Or like a whale. 
Ham. Then will I come to my mother by-and-by.- They fool me to the 
  top of my bent.- I will come by-and-by. 
Ham. 'By-and-by' is easily said.- Leave me, friends. 
                                      [Exeunt all but Hamlet.]   
  'Tis now the very witching time of night, 
  When churchyards yawn, and hell itself breathes out 
  Contagion to this world. Now could I drink hot blood 
It also catches stage directions. We could eliminate that problem with a more specific regular expression, but this isn't bad for now. Hopefully, you're interested enough in regular expressions to check out their chapter.
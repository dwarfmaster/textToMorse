#!/usr/bin/lua

if not (#arg == 1) then
	print("Nécessite un (seul) argument !")
	os.exit()
end

delay = function(time)
	first = os.clock()
	while (os.clock() - first) < time do
	end
end

beep = function(duration) os.execute("beep -l " .. (duration*1000)) end
clock = 0.25 -- in seconds
read_morse = function(code)
	for i=1,string.len(code) do
		if string.sub(code, i, i) == "." then
			beep(clock)
		elseif string.sub(code, i, i) == "-" then
			beep(clock * 3)
		end
		delay(clock)
	end
end

morse_tab = {a=".-", b="-...", c="-.-.", d="-..", e=".", f="..-.", g="--.", h="....", i="..", j=".---", k="-.-", l=".-..", m="--", n="-.", o="---", p=".--.", q="--.-", r=".-.", s="...", t="-", u="..-", v="...-", w=".--", x="-..-", y="-.--", z="--.."} -- Nombres à gérer : , ".----", "..---", "...--", "....-", ".....", "-....", "--...", "---..", "----.", "-----"}
parse_char = function(char)
	if morse_tab[char] then
		read_morse(morse_tab[char])
	elseif char == " " or char == "\n" then
		delay(clock * 5)
	end
end

file = io.open(arg[1], "r")
if file == nil then
	print("Problème à l'ouverture du fichier.")
	os.exit()
end

for line in file:lines() do
	line = string.lower(line)
	for i=1,string.len(line) do
		parse_char(string.sub(line, i, i))
		delay(clock * 2)
	end
end



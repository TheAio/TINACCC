function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end
function get_file_lines(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end
lines = get_file_lines("Existing_computers.txt")
if #lines > 0 then
  file = io.open("Existing_computers.txt", "w")
  file:write(#lines+1)
elseif file_exists("Existing_computers.txt") then
  file = io.open("Existing_computers.txt", "w")
  file:write(1)
else
  print("Error: unable to to find file 'Existing_computers.txt' TINACCC might be installed incorrectly and can not continue")
end

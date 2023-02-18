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
NewId = 1
if #lines > 0 then
  file = io.open("Existing_computers.txt", "w")
  file:write(#lines+1)
  file:close()
  NewId = #lines+1
elseif file_exists("Existing_computers.txt") then
  file = io.open("Existing_computers.txt", "w")
  file:write(1)
  file:close()
  NewId = #lines+1
else
  print("Error: unable to to find file 'Existing_computers.txt' TINACCC might be installed incorrectly and can not continue")
  return -1
end
os.execute("mkdir computers/"..NewId)
function copy(from,to)
  local lines = get_file_lines(from)
  if file_exists(to) then
    print("Warning: unable to copy file '"..from.."' because file '"..to.."' already exists")
    return -1
  else
    file = io.open(to, "w")
    for line=1, #lines do
      file:write(lines[line])
    end
    file:close()
  end
end
errors = 0
if file_exists("template/FilesToCopy.txt") then
  i = get_file_lines("template/FilesToCopy.txt")
  for j=1, #i do
    if copy("template/"..i[j],NewId.."/"..i[j]) == -1 then
      errors = errors + 1
    end
  end
  if errors > 0 then
    print("Info: the computer "..NewId.." has been made but there was "..errors.." errors during copying, some files may be missing")
  end
else
  print("Error: unable to to find file 'template/FilesToCopy.txt' TINACCC might be installed incorrectly and can not continue")
  return -1
end

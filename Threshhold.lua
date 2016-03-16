require'image'

Threshhold = class(function(thr,dataPath)
              acc.thr = thr, acc.dP=dataPath
           end)

function Threshhold:recalculateThreshhold(filter)
  files = {}

-- Go over all files in directory. We use an iterator, paths.files().
for file in paths.files(acc.dP) do
   -- We only load files that match the extension
   if file:find('jpg' .. '$') then
      -- and insert the ones we care about in our table
      table.insert(files, paths.concat(acc.dP,file))
   end
end

-- Check files
if #files == 0 then
   --error('given directory doesnt contain any files of type: ' .. 'jpg')
   createFilterSet()
end

images = {}
for i,file in ipairs(files) do
   -- load each image
   table.insert(images, image.load(file))
end

print('Loaded images:')

end

function Threshhold:createFilterSet

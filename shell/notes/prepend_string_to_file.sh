echo "This should appear second" > text.txt

# this is where the magic happens
cat <(echo "This should appear first") text.txt > newfile.txt
mv newfile.txt text.txt

cat text.txt
rm text.txt

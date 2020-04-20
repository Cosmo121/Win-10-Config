mbr2gpt /convert /disk0 /allowfullos

# If you receive: "Cannot find OS partition(s) for disc C", run:
bcdboot.exe c:\windows

# You may need to hide an additional drive letter, or it will keep trying to encrypt it

# Start diskpart
diskpart

# List the available disks
list disk

# Select the main drive
select disk x

# List the available volumes
list volumes

# Select the volume you want to remove drive letter for
select volume x

# Remove letter
remove letter=x

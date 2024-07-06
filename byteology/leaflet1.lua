pr = peripheral.find("printer")
pr.newPage()
-- 25 x 21 page size

pr.setPageTitle("THE END IS NEAR!")

pr.setCursorPos(5, 1)
pr.write("THE END IS NEAR!")

pr.setCursorPos(9, 3)
pr.write("ONLY OUR")
pr.setCursorPos(5, 4)
pr.write("LORD AND SAVIOUR")

pr.setCursorPos(6, 7)
pr.write("BYTE THE GREAT")
pr.setCursorPos(8, 9)
pr.write("CAN SAVE US!")

pr.setCursorPos(7, 13)
pr.write("SEEK REBIRTH!")
pr.setCursorPos(3, 14)
pr.write("BECOME A FOLLOWER OF")
pr.setCursorPos(7, 16)
pr.write("BYTEOLOGY")


pr.setCursorPos(1, 21)
pr.write("More info coming soon..")
pr.endPage()
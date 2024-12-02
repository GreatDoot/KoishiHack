Imports System
Imports System.IO

Module PTABLE_Macro_Fix
    Sub Main(args As String())

        ' declare variables
        Dim filenum As Integer = FreeFile()
        Dim CurrentFileName As String = ""
        Dim FileLength As Integer = 0
        Dim FileArray() As String
        Dim FileList() As String = Directory.GetFiles("..\..\Maps\", "*.event")

        ' start main for loop (for each .event in maps)
        For index = 0 To FileList.Length - 1

            ' store current file name
            CurrentFileName = FileList(index)

            ' print it so this program appears to do more (is this some sort of psychological fallacy?)
            Console.WriteLine(Microsoft.VisualBasic.Mid(CurrentFileName, 12))

            ' get the length of the file (still subtract one from it!)
            FileLength = File.ReadAllLines(CurrentFileName).Length

            ' make the array storing the contents of the file be the correct size
            ReDim Preserve FileArray(FileLength)

            ' open the file to read from it
            FileOpen(filenum, CurrentFileName, OpenMode.Input)

            For counter = 0 To FileLength - 1

                ' copy over file lines to each array index
                FileArray(counter) = LineInput(filenum)

                ' Tile Change macro replacement (I love you .Left)
                If Microsoft.VisualBasic.Left(FileArray(counter), 18) = "EventPointerTable(" Then
                    FileArray(counter) = "SetTileChanges(" & Microsoft.VisualBasic.Mid(FileArray(counter), 19)
                End If

                ' Map Data macro replacement (I love you .Mid)
                If Microsoft.VisualBasic.Mid(FileArray(counter), 271, 40) = "EventPointerTable(MapID,MapPointer); POP" Then
                    FileArray(counter) = "#define SetChapterData(ChapterID,ObjectType1,ObjectType2,PaletteID,TileConfig,MapID,MapPointer,Anims1,Anims2,MapChanges) " & Chr(34) & "PUSH; ORG ChapterDataTable+(ChapterID*ChapterDataTableEntSize)+4; BYTE ObjectType1 ObjectType2 PaletteID TileConfig MapID Anims1 Anims2 MapChanges; SetMapData(MapID,MapPointer); POP" & Chr(34)
                End If

            Next

            ' close file
            FileClose(filenum)

            ' delete old file (still in FileArray())
            File.Create(CurrentFileName).Dispose()

            ' open new blank file for writing to
            FileOpen(filenum, CurrentFileName, OpenMode.Output)

            ' loop through and write the contents of FileArray to each line of the file, essentially making an edit of the original
            For counter = 0 To FileLength - 1
                PrintLine(filenum, FileArray(counter))
            Next

            ' close file to stop random crash issues
            FileClose(filenum)
        Next

        Console.WriteLine("Done! Map files have been edited for compatibility with split PTABLE.")
    End Sub
End Module

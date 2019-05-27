PROGRAM RestoranDeco;
USES crt;

CONST
  nMax = 20;
{----------------------------------Type Bentukan----------------------------------}
TYPE
  MAKAN = RECORD
    NAMA : STRING;
    HARGA : LONGINT;
    END;

TYPE MAKANAN = array [1..nMax] of MAKAN;

TYPE
  MINUM = RECORD
    NAMA : STRING;
    HARGA : LONGINT;
    END;

TYPE MINUMAN = array [1..nMax] of MINUM;

TYPE
  CUSTOM = RECORD
    NAMA : STRING;
    BIAYA : LONGINT;
  END;

TYPE CUSTOMER = array [1..nMax] of CUSTOM;

TYPE
  DAF = RECORD
    nama : string;
    jumlah : integer;
    harga : longint;
  END;

TYPE DAFTAR = array [1..100] of DAF;

VAR
  ArrMinum : MINUMAN;
  ArrMakan : MAKANAN;
  ArrCustom : CUSTOMER;
  ArrDaftar : DAFTAR;
  X, jumlah, jum_makan, jum_minum, jum_custom, PIL, sah : INTEGER;
  cari_menu : string;
  menu_makanan : textfile;
  menu_minuman : textfile;
  pembeli : textfile;
{------------------------------------MENU TAMPILAN-----------------------------------}

PROCEDURE MENU(VAR x : integer);
  BEGIN
  CLRSCR;
  WRITELN;
  WRITELN('                   Restoran Deco                   ');
  WRITELN('   Jl. Telekomunikasi No.50, Bojongsoang, Bandung   ');
  WRITELN('____________________________________________________');
  WRITELN;
  WRITELN('                      M E N U                      ');
  WRITELN;
  WRITELN('   1.  Tampilkan Menu Makanan ');
  WRITELN('   2.  Tampilkan Menu Minuman ');
  WRITELN('   3.  Pencarian Menu ');
  WRITELN('   4.  Urutkan Berdasarkan ');
  WRITELN('   5.  Pemesanan ');
  WRITELN('   6.  Admin Panel ');
  WRITELN('   7.  Keluar');
  WRITELN;
  WRITE('   Pilih menu : ');
  READLN(x);
  END;

{-----------------------------MENU PANEL--------------------------------------}

PROCEDURE MENUPANEL(VAR pil : integer);
    BEGIN
    WRITELN;
    WRITELN;
    WRITELN('              Admin Panel Restoran Deco                   ');
    WRITELN('   Jl. Telekomunikasi No.50, Bojongsoang, Bandung   ');
    WRITELN('____________________________________________________');
    WRITELN;
    WRITELN('                P A N E L  M E N U  A D M I N                     ');
    WRITELN;
    WRITELN('   1.  Input Makanan ');
    WRITELN('   2.  Input Minuman ');
    WRITELN('   3.  Edit Menu Makanan ');
    WRITELN('   4.  Edit Menu Minuman ');
    WRITELN('   5.  Delete Menu Makanan ');
    WRITELN('   6.  Delete Menu Minuman ');
    WRITELN('   7.  Simpan Data ke Database');
    WRITELN('   8.  Ambil Data dari Database');
    WRITELN('   9.  Kembali Ke Menu ');
    WRITELN;
    WRITE('   Pilih menu : ');
    READLN(pil);
    END;

{-------------------------------CEK MAKANAN------------------------------------}

FUNCTION cekmakan(input : string; ArrMakan : MAKANAN; jum_makan : integer) : integer;
  VAR
    i, cek : integer;
  BEGIN
    i := 1;
    cek := 0;
    WHILE ((i < jum_makan) AND (cek=0))  DO
    BEGIN
      IF ArrMakan[i].nama = input THEN
      BEGIN
        cek := 1;
      END;
      i := i + 1;
    END;
    cekmakan := cek;
  END;

{-------------------------------CEK MINUMAN------------------------------------}

FUNCTION cekminum(input : string; ArrMinum : MINUMAN; jum_minum : integer) : integer;
  VAR
    i, cek : integer;
  BEGIN
    i := 1;
    cek := 0;
    WHILE ((i < jum_minum) AND (cek=0))  DO
    BEGIN
      IF ArrMinum[i].nama = input THEN
      BEGIN
        cek := 1;
      END;
      i := i + 1;
    END;
    cekminum := cek;
  END;

{------------------------------Ambil Data Minuman-------------------------}

FUNCTION ambildataminum(VAR ArrMinum : MINUMAN; jum_minum : integer) : integer;
  VAR
    i : integer;
    str : string;
    long : LONGINT;
  BEGIN
    i := 1;
    ASSIGN(menu_minuman, 'menu_minuman.dat');
    RESET(menu_minuman);
    WHILE NOT eof (menu_minuman) DO
          BEGIN
                   READLN(menu_minuman, str);
                   ArrMinum[i].NAMA  :=  str;
                   READLN(menu_minuman, long);
                   ArrMinum[i].HARGA  :=  long;
                   i := i + 1;
                   jum_minum := jum_minum + 1;
          END;
    CLOSE(menu_minuman);
      ambildataminum := jum_minum;
      CLRSCR;
      WRITELN;
      WRITELN('  DATA TELAH DIAMBIL DARI DATABASE!  ');
      READLN;
      CLRSCR;
  END;

{------------------------------Ambil Data Makanan-------------------------}

FUNCTION ambildatamakan(VAR ArrMakan : MAKANAN; jum_makan : integer) : integer;
  VAR
    i : integer;
    str : string;
    long : LONGINT;
  BEGIN
    i := 1;
    ASSIGN(menu_makanan, 'menu_makanan.dat');
      RESET(menu_makanan);
      WHILE NOT eof (menu_makanan) DO
            BEGIN
                     READLN(menu_makanan, str);
                     ArrMakan[i].NAMA  :=  str;
                     READLN(menu_makanan, long);
                     ArrMakan[i].HARGA  :=  long;
                     i := i + 1;
                     jum_makan := jum_makan + 1;
            END;
      CLOSE(menu_makanan);
      ambildatamakan := jum_makan;
  END;

{------------------------------------INPUT_MAKAN-----------------------------------}

PROCEDURE INPUT_MAKAN(VAR ArrMakan : MAKANAN; jumlah : INTEGER; jum_makan : INTEGER);
  VAR
    i : integer;
    input : string;
  BEGIN
    CLRSCR;
    i := jum_makan - jumlah;
    WRITELN;
    WHILE i < jum_makan DO
    BEGIN
        WRITELN('   Makanan ke',i);
        WRITE('    Nama Makanan : ');
        READLN(input);
        IF cekmakan(input,ArrMakan,jum_makan)=0 THEN
        BEGIN
          ArrMakan[i].nama := input;
          WRITE('    Harga : Rp ');
          READLN(ArrMakan[i].harga);
        END
        ELSE
        BEGIN
          writeln;
          writeln(' Nama Makanan Sudah Ada');
          READLN;
          CLRSCR;
          WRITELN;
          i := i - 1;
        END;
        i := i + 1;
    END;
    CLRSCR;
  END;

{------------------------------------INPUT_MINUM-----------------------------------}

PROCEDURE INPUT_MINUM(VAR ArrMinum : MINUMAN; jumlah : INTEGER; jum_minum : INTEGER);
  VAR
    i : integer;
    input : string;
  BEGIN
    CLRSCR;
    i := jum_minum - jumlah;
    WRITELN;
    WHILE i < jum_minum DO
    BEGIN
      WRITELN('   Minuman ke',i);
      WRITE('    Nama Minuman : ');
      readln(input);
      IF cekminum(input,ArrMinum,jum_minum)=0 THEN
      BEGIN
        ArrMinum[i].nama := input;
        WRITE('    Harga : Rp ');
        READLN(ArrMinum[i].harga);
      end
      ELSE
      BEGIN
        writeln;
        writeln(' Nama Minuman Sudah Ada');
        READLN;
        CLRSCR;
        WRITELN;
        i := i - 1;
      END;
      i := i + 1;
    END;
    CLRSCR;
  END;

{------------------------------------EDIT_MAKAN------------------------------------}

PROCEDURE EDIT_MAKAN(VAR ArrMakan : MAKANAN; jum_makan : integer);
  VAR
    i, edit : integer;
  BEGIN
    WRITELN('               M E N U    M A K A N A N                      ');
    WRITELN;
    i := 1;
    WHILE i < jum_makan  DO
    BEGIN
          WRITELN;
          WRITELN('   ',i,'.  ',ArrMakan[i].nama);
          WRITELN('        Rp ',ArrMakan[i].harga);
        i := i + 1;
    END;
    WRITELN;
    WRITE('    Pilih yang ingin di Edit? ');
    READLN(edit);
    WRITE('       Nama   :  ');
    READLN(ArrMakan[edit].nama);
    WRITE('       Harga  :  ');
    READLN(ArrMakan[edit].harga);
    CLRSCR;
    WRITELN;
    WRITELN('          DATA BERHASIL DIGANTI!');
    READLN;
    CLRSCR;
  END;

{--------------------------------------EDIT_MINUM---------------------------------}

PROCEDURE EDIT_MINUM(VAR ArrMinum : MINUMAN; jum_minum : integer);
  VAR
    i, edit : integer;
  BEGIN
  WRITELN;
  WRITELN('                   Restoran Deco                   ');
  WRITELN('   Jl. Telekomunikasi No.50, Bojongsoang, Bandung   ');
  WRITELN('____________________________________________________');
  WRITELN;
  WRITELN('               M E N U    M I N U M A N                      ');
  WRITELN;
  i := 1;
  WHILE i < jum_minum DO
  BEGIN
    with ArrMinum[i] do
      BEGIN
        WRITELN;
        WRITELN('   ',i,'.  ',NAMA);
        WRITELN('        Rp ',HARGA);
      END;
      i := i + 1;
  END;
  WRITELN;
  WRITE('    Pilih yang ingin di Edit? ');
  READLN(edit);
  WRITE('       Nama   :  ');
  READLN(ArrMinum[edit].nama);
  WRITE('       Harga  :  ');
  READLN(ArrMinum[edit].harga);
  CLRSCR;
  WRITELN;
  WRITELN('       DATA BERHASIL DIGANTI!');
  READLN;
  CLRSCR;
  END;

{--------------------------------------Delete_makan------------------------------}

PROCEDURE DELETE_MAKAN(VAR ArrMakan : MAKANAN; jum_makan : integer);
  VAR
    i, tempat, delete : integer;
    tempat1 : string;
  BEGIN
    WRITELN;
    WRITELN('               M E N U    M A K A N A N                      ');
    WRITELN;
    i := 1;
    WHILE i < jum_makan  DO
    BEGIN
      with ArrMakan[i] do
        BEGIN
          WRITELN;
          WRITELN('   ',i,'.  ',NAMA);
          WRITELN('        Rp ',HARGA);
        END;
        i := i + 1;
    END;
    WRITELN;
    WRITELN;
    WRITE('    Pilih yang ingin di Delete? ');
    READLN(delete);
    ArrMakan[delete].nama :=' ';
    ArrMakan[delete].harga := 0;
    WHILE delete <= jum_makan Do
    BEGIN
      tempat := ArrMakan[delete].harga;
      ArrMakan[delete].harga := ArrMakan[delete+1].harga;
      ArrMakan[delete+1].harga := tempat;
      tempat1 := ArrMakan[delete].nama;
      ArrMakan[delete].nama := ArrMakan[delete+1].nama;
      ArrMakan[delete+1].nama := tempat1;
      delete := delete + 1;
    END;
    CLRSCR;
    WRITELN;
    WRITELN('          DATA BERHASIL DIHAPUS!');
    READLN;
    CLRSCR;
  END;

{--------------------------------------DELETE_MINUM-----------------------------}

PROCEDURE DELETE_MINUM(VAR ArrMinum : MINUMAN; jum_minum : integer);
  VAR
    i, delete, tempat : integer;
    tempat1 : string;
  BEGIN
  WRITELN('                   Restoran Deco                   ');
  WRITELN('   Jl. Telekomunikasi No.50, Bojongsoang, Bandung   ');
  WRITELN('____________________________________________________');
  WRITELN;
  WRITELN('               M E N U    M I N U M A N                      ');
  WRITELN;
  i := 1;
  WHILE i < jum_minum DO
  BEGIN
    with ArrMinum[i] do
      BEGIN
        WRITELN;
        WRITELN('   ',i,'.  ',NAMA);
        WRITELN('        Rp ',HARGA);
      END;
      i := i + 1;
  END;
  WRITELN;
  WRITE('    Pilih yang ingin di Delete? ');
  READLN(delete);
  ArrMinum[delete].nama :=' ';
  ArrMinum[delete].harga := 0;
  CLRSCR;
  WRITELN;
  WRITELN('       DATA BERHASIL DIHAPUS!');
  WHILE delete <= jum_minum Do
    BEGIN
      tempat := ArrMinum[delete].harga;
      ArrMinum[delete].harga := ArrMinum[delete+1].harga;
      ArrMinum[delete+1].harga := tempat;
      tempat1 := ArrMinum[delete].nama;
      ArrMinum[delete].nama := ArrMinum[delete+1].nama;
      ArrMinum[delete+1].nama := tempat1;
      delete := delete + 1;
    END;
    CLRSCR;
    WRITELN;
    WRITELN('          DATA BERHASIL DIHAPUS!');
    READLN;
    CLRSCR;
  END;

{------------------------------------MENU MINUMAN-----------------------------------}

PROCEDURE MENUMINUMAN(var ArrMinum : MINUMAN; jum_minum : integer);
  VAR
    i : integer;
  BEGIN
  CLRSCR;
  WRITELN;
  WRITELN('                   Restoran Deco                   ');
  WRITELN('   Jl. Telekomunikasi No.50, Bojongsoang, Bandung   ');
  WRITELN('____________________________________________________');
  WRITELN;
  WRITELN('               M E N U    M I N U M A N                      ');
  WRITELN;
  i := 1;
  WHILE i < jum_minum DO
  BEGIN
    with ArrMinum[i] do
      BEGIN
        WRITELN;
        WRITELN('   ',i,'.  ',NAMA);
        WRITELN('        Rp ',HARGA);
      END;
      i := i + 1;
  END;
  READLN;
  CLRSCR;
  END;

{------------------------------------MENU MAKANAN-----------------------------------}

PROCEDURE MENUMAKANAN(var ArrMakan : MAKANAN; jum_makan : INTEGER);
  VAR
    i : INTEGER;
  BEGIN
  CLRSCR;
  WRITELN;
  WRITELN('                   Restoran Deco                   ');
  WRITELN('   Jl. Telekomunikasi No.50, Bojongsoang, Bandung   ');
  WRITELN('____________________________________________________');
  WRITELN;
  WRITELN('               M E N U    M A K A N A N                      ');
  WRITELN;
  i := 1;
  WHILE i < jum_makan  DO
  BEGIN
        WRITELN;
        with ArrMakan[i] DO
        BEGIN
        WRITELN('   ',i,'.  ',nama);
        WRITELN('        Rp ',harga);
        END;
      i := i + 1;
  END;
  READLN;
  CLRSCR;
  END;

{-----------------------------------Searching_Menu---------------------------------------------}

PROCEDURE Searching_Makan(var jum_makan : integer; jum_minum : integer; ArrMakan : MAKANAN; ArrMinum : MINUMAN; cari_menu : string);
    VAR
      i : integer;
    BEGIN
      i := 1;
      WRITELN;
      WRITELN;
      WRITELN('    Menu Makanan');
      WHILE i <= jum_makan DO
      BEGIN
        IF(POS(cari_menu,ArrMakan[i].nama)=1) THEN
        BEGIN
          WRITELN('      ',ArrMakan[i].nama);
          WRITELN('        Harga Rp',ArrMakan[i].harga);
          WRITELN;
        END;
        i := i + 1;
      END;
      WRITELN;
      WRITELN;
      WRITELN('    Menu Minuman');
      i := 1;
      WHILE i <= jum_minum DO
      BEGIN
        IF (POS(cari_menu,ArrMinum[i].nama)=1) THEN
        BEGIN
          WRITELN('      ',ArrMinum[i].nama);
          WRITELN('        Harga Rp',ArrMinum[i].harga);
          WRITELN;
        END;
        i := i + 1;
      END;
      WRITELN;
      WRITELN;
      WRITELN;
      WRITELN;
      READLN;
      END;

{-----------------------------------Sorting_Menu-----------------------------------------}

PROCEDURE SORTING_MENU(VAR ArrMakan : MAKANAN; ArrMinum : MINUMAN; jum_makan : integer; jum_minum : integer);
  VAR
    i, n, pilihan: integer;
    tukar : LONGINT;
    abtukar : string;
  BEGIN
    i := 1;
    n := 1;
    WRITELN('Urutkan Berdasarkan : ');
    WRITELN('1. Harga Dari Yang Termurah');
    WRITELN('2. Harga Dari Yang Termahal');
    WRITELN('3. Abjad A-Z');
    WRITELN('4. Abzad Z-A');
    WRITELN;
    WRITE('Pilih nomor : ');
    READLN(pilihan);
    IF pilihan=1 THEN
    BEGIN
      WHILE i < jum_makan DO
      BEGIN
        WHILE n < (jum_makan-1) DO
        BEGIN
          IF (ArrMakan[n].harga>=ArrMakan[n+1].harga) THEN
          BEGIN
              tukar := ArrMakan[n].harga;
              abtukar := ArrMakan[n].nama;
              ArrMakan[n].harga := ArrMakan[n+1].harga;
              ArrMakan[n].nama := ArrMakan[n+1].nama;
              ArrMakan[n+1].harga := tukar;
              ArrMakan[n+1].nama := abtukar;
          END;
          n := n + 1;
        END;
        i := i + 1;
        n := 1;
      END;

      i := 1;
      n := 1;

      WHILE i < jum_minum DO
      BEGIN
        WHILE n < (jum_minum-1) DO
        BEGIN
          IF (ArrMinum[n].harga>=ArrMinum[n+1].harga) THEN
          BEGIN
              tukar := ArrMinum[n].harga;
              abtukar := ArrMinum[n].nama;
              ArrMinum[n].harga := ArrMinum[n+1].harga;
              ArrMinum[n].nama := ArrMinum[n+1].nama;
              ArrMinum[n+1].harga := tukar;
              ArrMinum[n+1].nama := abtukar;
          END;
          n := n + 1;
        END;
        i := i + 1;
        n := 1;
      END;
      CLRSCR;
      MENUMAKANAN(ArrMakan,jum_makan);
      MENUMINUMAN(ArrMinum,jum_minum);
    END

    ELSE IF pilihan=2 THEN
    BEGIN
      WHILE i < jum_makan DO
      BEGIN
        WHILE n < (jum_makan-1) DO
        BEGIN
          IF (ArrMakan[n].harga<=ArrMakan[n+1].harga) THEN
          BEGIN
            tukar := ArrMakan[n].harga;
            abtukar := ArrMakan[n].nama;
            ArrMakan[n].harga := ArrMakan[n+1].harga;
            ArrMakan[n].nama := ArrMakan[n+1].nama;
            ArrMakan[n+1].harga := tukar;
            ArrMakan[n+1].nama := abtukar;
          END;
          n := n + 1;
        END;
        i := i + 1;
        n := 1;
        END;
        i := 1;
        n := 1;

        WHILE i < jum_minum DO
        BEGIN
          WHILE n < (jum_minum-1) DO
          BEGIN
            IF (ArrMinum[n].harga<=ArrMinum[n+1].harga) THEN
            BEGIN
                tukar := ArrMinum[n].harga;
                abtukar := ArrMinum[n].nama;
                ArrMinum[n].harga := ArrMinum[n+1].harga;
                ArrMinum[n].nama := ArrMinum[n+1].nama;
                ArrMinum[n+1].harga := tukar;
                ArrMinum[n+1].nama := abtukar;
            END;
            n := n + 1;
          END;
          i := i + 1;
          n := 1;
        END;
        CLRSCR;
        MENUMAKANAN(ArrMakan,jum_makan);
        MENUMINUMAN(ArrMinum,jum_minum);
    END
        ELSE IF pilihan=3 THEN
        BEGIN
          WHILE i < jum_makan DO
          BEGIN
            WHILE n < (jum_makan-1) DO
            BEGIN
              IF (ArrMakan[n].nama>=ArrMakan[n+1].nama) THEN
              BEGIN
                tukar := ArrMakan[n].harga;
                abtukar := ArrMakan[n].nama;
                ArrMakan[n].harga := ArrMakan[n+1].harga;
                ArrMakan[n].nama := ArrMakan[n+1].nama;
                ArrMakan[n+1].harga := tukar;
                ArrMakan[n+1].nama := abtukar;
              END;
              n := n + 1;
            END;
            i := i + 1;
            n := 1;
          END;

          i := 1;
          n := 1;

          WHILE i < jum_minum DO
          BEGIN
            WHILE n < (jum_minum-1) DO
              BEGIN
                IF (ArrMinum[n].nama>=ArrMinum[n+1].nama) THEN
                BEGIN
                  tukar := ArrMinum[n].harga;
                  abtukar := ArrMinum[n].nama;
                  ArrMinum[n].harga := ArrMinum[n+1].harga;
                  ArrMinum[n].nama := ArrMinum[n+1].nama;
                  ArrMinum[n+1].harga := tukar;
                  ArrMinum[n+1].nama := abtukar;
                END;
                n := n + 1;
            END;
            i := i + 1;
            n := 1;
          END;
          CLRSCR;
          MENUMAKANAN(ArrMakan,jum_makan);
          MENUMINUMAN(ArrMinum,jum_minum);
        END

        ELSE IF pilihan=4 THEN
        BEGIN
          WHILE i < jum_makan DO
          BEGIN
            WHILE n < (jum_makan-1) DO
            BEGIN
              IF (ArrMakan[n].nama<=ArrMakan[n+1].nama) THEN
              BEGIN
                tukar := ArrMakan[n].harga;
                abtukar := ArrMakan[n].nama;
                ArrMakan[n].harga := ArrMakan[n+1].harga;
                ArrMakan[n].nama := ArrMakan[n+1].nama;
                ArrMakan[n+1].harga := tukar;
                ArrMakan[n+1].nama := abtukar;
              END;
              n := n + 1;
            END;
            i := i + 1;
            n := 1;
          END;
          i := 1;
          n := 1;

            WHILE i < jum_minum DO
            BEGIN
              WHILE n < (jum_minum-1) DO
              BEGIN
                IF (ArrMinum[n].nama<=ArrMinum[n+1].nama) THEN
                BEGIN
                  tukar := ArrMinum[n].harga;
                  abtukar := ArrMinum[n].nama;
                  ArrMinum[n].harga := ArrMinum[n+1].harga;
                  ArrMinum[n].nama := ArrMinum[n+1].nama;
                  ArrMinum[n+1].harga := tukar;
                  ArrMinum[n+1].nama := abtukar;
                END;
                n := n + 1;
              END;
              i := i + 1;
              n := 1;
          END;
          CLRSCR;
          MENUMAKANAN(ArrMakan,jum_makan);
          MENUMINUMAN(ArrMinum,jum_minum);
        END;
    END;

{-----------------------------------------BiayaPemesanan-----------------------------------------------}

FUNCTION BiayaPemesanan(ArrMakan : MAKANAN; ArrMinum : MINUMAN; nomor : integer; pesan  : integer; pesan2 : integer; nomor2 : integer): LONGINT;
  var
    harga_makan, harga_minum, hargatotal : LONGINT;
  BEGIN
    harga_makan := ArrMakan[nomor].harga*pesan;
    harga_minum := ArrMinum[nomor2].harga*pesan2;
    hargatotal := harga_makan + harga_minum;
    BiayaPemesanan := hargatotal;
  END;

{-------------------------------------Pemesanan---------------------------------------}

PROCEDURE Pemesanan(VAR ArrDaftar : DAFTAR; ArrCustom : CUSTOMER; ArrMakan : MAKANAN; ArrMinum : MINUMAN; jum_makan : integer; jum_minum : integer; jum_custom : integer);
    VAR
      z, i, pesan, pesan2, nomor2, nomor, harga : integer;
      sudah, nama : string;
      total_harga : LONGINT;
    BEGIN
      z := 1;
      total_harga := 0;
      pesan2 := 0;
      nomor2 := 1;
      sudah := 'Y';
      i := 1;
      WRITELN;
      WRITELN;
      WRITE('    Nama Customer : ');
      READLN(nama);
      WRITELN;
      WRITELN;
      WRITELN('    Menu Makanan');
      WHILE i < jum_makan DO
      BEGIN
        WRITELN;
        WRITELN('  ',i,'. ',ArrMakan[i].nama);
        WRITELN('         ',ArrMakan[i].harga);
        i := i + 1;
      END;
      WHILE sudah='Y' DO
      BEGIN
        WRITELN;
        WRITE('Pesan Makanan Yang Mana ? ');
        READLN(nomor);
        WRITELN;
        WRITE('Pesan Berapa : ');
        READLN(pesan);
        ArrDaftar[z].nama := ArrMakan[nomor].nama;
        ArrDaftar[z].harga := ArrMakan[nomor].harga;
        ArrDaftar[z].jumlah := pesan;
        z := z + 1;
        total_harga := BiayaPemesanan(ArrMakan,ArrMinum,nomor,pesan,pesan2,nomor2) + total_harga;
        WRITELN('Mau Pesan Makanan Lagi? Y/T');
        READLN(sudah);
      END;
      nomor := 1;
      pesan := 0;
      sudah :='Y';
      i := 1;
      WRITELN;
      WRITELN('    Menu Minuman');
      WHILE i < jum_minum DO
      BEGIN
        WRITELN;
        WRITELN('  ',i,'. ',ArrMinum[i].nama);
        WRITELN('         ',ArrMinum[i].harga);
        i := i + 1;
      END;
      WHILE sudah='Y' do
      BEGIN
        WRITE('Pesan Minuman Yang Mana ? ');
        READLN(nomor2);
        WRITELN;
        WRITE('Pesan Berapa : ');
        READLN(pesan2);
        ArrDaftar[z].nama := ArrMinum[nomor2].nama;
        ArrDaftar[z].harga := ArrMinum[nomor2].harga;
        ArrDaftar[z].jumlah := pesan2;
        z := z + 1;
        total_harga := BiayaPemesanan(ArrMakan,ArrMinum,nomor,pesan,pesan2,nomor2) + total_harga;
        WRITELN('Mau Pesan Minuman Lagi? Y/T');
        READLN(sudah);
      END;
      CLRSCR;
      i := 1;
      WRITELN;
      WRITELN;
      WRITELN('        NOTA PEMBAYARAN RESTORAN DECO    ');
      WRITELN;
      WRITELN('        NAMA CUSTOMER         : ',nama);
      WRITELN;
      WRITELN('        DAFTAR YANG DIPESAN : ');
      WHILE i < z DO
      BEGIN
        WRITELN;
        WRITELN('        ',i,'. ',ArrDaftar[i].nama);
        WRITELN('            Harga Rp',ArrDaftar[i].harga);
        WRITELN('            Jumlah Memesan : ',ArrDaftar[i].jumlah);
      i := i + 1;
      END;
      WRITELN('        Total Pembayaran Anda : Rp ',total_harga);
      ArrCustom[jum_custom].NAMA := nama;
      ArrCustom[jum_custom].BIAYA := total_harga;
      assign(pembeli,'pembeli.dat');
      append(pembeli);
      WRITELN(pembeli,' Nama Pembeli : ',ArrCustom[jum_custom].NAMA);
      WRITELN(pembeli,' Total Biaya  : ',ArrCustom[jum_custom].BIAYA);
      WRITELN(pembeli,' ');
      close(pembeli);
      WRITELN;
      WRITELN('        Terima Kasih Telah Membeli Makanan di Restoran Deco');
      WRITELN;
      WRITELN;
      WRITELN;
      READLN;
      i := 1;
      WHILE i < z DO
      BEGIN
        ArrDaftar[i].nama := '';
        ArrDaftar[i].harga := 0;
        ArrDaftar[i].jumlah := 0;
        i := i + 1;
      END;
      END;

{-------------------------------------SimpanData-----------------------------------------}

PROCEDURE SimpanData(VAR ArrCustom : CUSTOMER; ArrMakan : MAKANAN; ArrMinum : MINUMAN; jum_makan : integer; jum_minum : integer; jum_custom : integer);
  VAR
            i : integer;
  BEGIN
            i := 1;
            assign(menu_makanan,'menu_makanan.dat');
            reWRITE(menu_makanan);
            WHILE i < jum_makan do
            BEGIN
              WRITELN(menu_makanan,ArrMakan[i].nama);
              WRITELN(menu_makanan,ArrMakan[i].harga);
              i := i + 1;
            END;
            close(menu_makanan);
            i := 1;
            assign(menu_minuman,'menu_minuman.dat');
            reWRITE(menu_minuman);
            WHILE i < jum_minum do
            BEGIN
              WRITELN(menu_minuman,ArrMinum[i].nama);
              WRITELN(menu_minuman,ArrMinum[i].harga);
              i := i + 1;
            END;
            close(menu_minuman);
            WRITELN;
            CLRSCR;
            WRITELN;
            WRITELN('  DATA TERSIMPAN!  ');
            READLN;
            CLRSCR;
    END;

{-----------------------------validasipassword--------------------------------}

PROCEDURE validasi(VAR sah : integer);
  VAR
    i, PIL, X : integer;
    iuser,user, ipass, pass : string;
    BEGIN
    user := 'ADMIN';
    pass := 'ADMIN';
    i := 1;
    sah := 0;
    WHILE ((i<=3) and (sah=0)) DO
    BEGIN
      CLRSCR;
      WRITELN;
      WRITELN('               Selamat Datang di Admin Panel Restoran Deco');
      WRITELN;
      WRITELN('____________________________________________________________________________________');
      WRITELN;
      WRITE('      Masukkan Username : ');
      READLN(iuser);
      WRITELN;
      WRITE('      Masukkan Password : ');
      READLN(ipass);
      if ((iuser=user) and (ipass=pass)) THEN
        BEGIN
          WRITELN('ANDA SUKSES LOGIN!');
          sah := 1;
        END
      else
        BEGIN
          WRITELN('Username atau Password Salah');
          i := i + 1;
        END;
    END;
    CLRSCR;
  END;

{----------------------------Program utama------------------------}

BEGIN
  CLRSCR;
  jum_custom := 1;
  jum_makan := 1;
  jum_minum := 1;
  REPEAT
  MENU(X);
  CASE x OF
  1  : BEGIN
          MENUMAKANAN(ArrMakan,jum_makan);
       END;
  2  : BEGIN
          MENUMINUMAN(ArrMinum,jum_minum);
       END;
  3  : BEGIN
          CLRSCR;
          WRITELN;
          WRITELN;
          WRITE('      Menu apa yang anda cari?    ');
          READLN(cari_menu);
          Searching_Makan(jum_makan,jum_minum,ArrMakan,ArrMinum,cari_menu);
       END;
  4  : BEGIN
          CLRSCR;
          SORTING_MENU(ArrMakan,ArrMinum,jum_makan,jum_minum);
       END;
  5  : BEGIN
          CLRSCR;
          Pemesanan(ArrDaftar,ArrCustom,ArrMakan,ArrMinum,jum_makan,jum_minum,jum_custom);
          jum_custom := jum_custom + 1;
       END;
  6  : BEGIN
          validasi(sah);
          IF  sah=1 THEN
          BEGIN
            CLRSCR;
            REPEAT
            MENUPANEL(pil);
            CASE PIL OF
              1 : BEGIN
                    CLRSCR;
                    WRITELN;
                    WRITELN;
                    WRITE('      Jumlah Makanan yang akan Didaftarkan : ');
                    READLN(jumlah);
                    jum_makan := jum_makan + jumlah;
                    INPUT_MAKAN(ArrMakan,jumlah,jum_makan);
                  END;
              2 : BEGIN
                    CLRSCR;
                    WRITELN;
                    WRITELN;
                    WRITE('      Jumlah Minuman yang Akan Didaftarkan : ');
                    READLN(jumlah);
                    jum_minum := jum_minum + jumlah;
                    INPUT_MINUM(ArrMinum,jumlah,jum_minum);
                  END;
              3 : BEGIN
                    CLRSCR;
                    EDIT_MAKAN(ArrMakan,jum_makan);
                  END;
              4 : BEGIN
                    CLRSCR;
                    EDIT_MINUM(ArrMinum,jum_minum);
                  END;
              5 : BEGIN
                    CLRSCR;
                    DELETE_MAKAN(ArrMakan,jum_makan);
                    jum_makan := jum_makan - 1;
                  END;
              6 : BEGIN
                    CLRSCR;
                    DELETE_MINUM(ArrMinum,jum_minum);
                    jum_minum := jum_minum - 1;
                  END;
              7 : BEGIN
                    CLRSCR;
                    SimpanData(ArrCustom,ArrMakan,ArrMinum,jum_makan,jum_minum,jum_custom);
                  END;
              8 : BEGIN
                    CLRSCR;
                    jum_makan := 0;
                    jum_minum := 0;
                    jum_makan := ambildatamakan(ArrMakan,jum_makan) + 1;
                    jum_minum := ambildataminum(ArrMinum,jum_minum) + 1;
                  END;
            END;
            UNTIL (PIL=9);
          END;
          CLRSCR;
       END;
  END;
  UNTIL (X=7);
  READLN;
END.

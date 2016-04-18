unit modul;

interface

{KAMUS UMUM}
Uses sysutils;

const
	MAXFILM = 10;
	MAXJADWAL = 1000;
	MAXPESAN = 10000;
	MAXMEMBER = 1000;
	
type
	
	data_film = record
				Judul : string;
				Genre : string;
				Rating : string;
				Durasi : string;
				SINOPSIS : AnsiString;
				HWeekDay : integer;
				HWeekEnd : integer;
				end;
				
	data_jadwal	= record
				Judul : string;
				JAM : string;
				TGL : integer;
				BLN : integer;
				THN : integer;
				SISA : integer;
				end;
				
	data_kapasitas = record
				Judul : string;
				TGL : integer;
				BLN : integer;
				THN : integer;
				JAM : string;
				SISA : integer;
				end;
				
	data_pesan	= record
				KODEBAYAR : string; 
				Judul : string; 
				JAM : string; 
				TGL : integer; 
				BLN : integer; 
				THN : integer; 
				NTIKET : integer; 
				TOTAL : longint;
				STATUS : string;
				end;
				
	data_member	= record 
				Username : string;
				PASSWORD : string; 
				SALDO : longint;
				end;
				
	today	= record
				TGL : integer; 
				BLN: integer; 
				THN: integer;
				HARI : string;
				end;

	AODF = Array [1..MAXFILM] of data_film;
	AOJT = Array [1..MAXJADWAL] of data_jadwal;
	AOKP = Array [1..MAXJADWAL] of data_kapasitas;
	AOPT = Array [1..MAXPESAN]of data_pesan;
	AODM = Array [1..MAXMEMBER] of data_member;
	

procedure load (var tabDF : AODF;
					tabDJT : AOJT;
					tabDPT : AOPT;
					tabDM : AODM;
					hariini : today;
					jumlahfilm:integer;
					jumlahjadwal:longint;
					jumlahpemesanan:longint;
					jumlahmember:longint);

					
implementation

procedure load (var tabDF : AODF;
					tabDJT : AOJT;
					tabDPT : AOPT;
					tabDM : AODM;
					hariini : today;
					jumlahfilm:integer;
					jumlahjadwal:longint;
					jumlahpemesanan:longint;
					jumlahmember:longint);

{KAMUS LOKAL}
const
	DF = 'datafilm.txt';
	DJT = 'datajadwaltayang.txt';
	DKP = 'datakapasitas.txt';
	DPT = 'datapemesanantiket.txt';
	DM = 'datamember.txt';
	DHI = 'datahariini.txt';

var
	tabDKP:AOKP;
	Judul : string;
	Genre : string;
	Rating : string;
	Durasi : string;
	SINOPSIS : AnsiString;
	HWeekDay : string;
	HWeekEnd : string;
	
	JAM : string;
	TGL : string;
	BLN : string;
	THN : string;
	SISA : integer;

	KODEBAYAR : string; 
	NTIKET : string; 
	TOTAL : string;
	STATUS : string;
	
	Username : string;
	PASSWORD : string; 
	SALDO : string;
	
	tempJudul:array [1..MAXJADWAL]of string;
	tempJAM:array [1..MAXJADWAL]of string;
	tempTGL:array [1..MAXJADWAL]of integer;
	tempBLN:array [1..MAXJADWAL]of integer;
	tempTHN:array [1..MAXJADWAL]of integer;
	
	datafilm : TextFile;
	datajadwaltayang : TextFile;
	datakapasitas : TextFile;
	datapemesanantiket : TextFile;
	datamember : TextFile;
	datahariini	 : TextFile;
	
	x : char;
	y : string;
	i : longint;
	j : integer;
	k : integer;
	count : integer;

{ALGORITMA}
begin
	assign( datafilm, DF);
	assign( datajadwaltayang, DJT);
	assign( datakapasitas, DKP);
	assign( datapemesanantiket, DPT);
	assign( datamember, DM);
	assign( datahariini, DHI);
	
	
	
	reset( datafilm);
	reset( datajadwaltayang);
	reset( datakapasitas);
	reset( datapemesanantiket);
	reset( datamember);
	reset( datahariini);
	
//=========================================================================================================================================================================================================
	j:=1;
	
	while not (EOF(datafilm)) do
	begin

		Judul:='';
		Genre:='';
		Rating:='';
		Durasi:='';
		SINOPSIS:='';
		HWeekDay:='';
		HWeekEnd:='';		
		
		{Judul}		
		read(datafilm, x);
		while not (x='|') do
		begin
			Judul:=Judul+x;
			read(datafilm, x);
		end;
		tabDF[j].Judul:=Judul;		
	
		{Genre}		
		read(datafilm, x);
		read(datafilm, x);
		while not (x='|') do
		begin
			Genre:=Genre+x;
			read(datafilm, x);
		end;
		tabDF[j].Genre:=Genre;
		
		{Rating}		
		read(datafilm, x);
		read(datafilm, x);
		while not (x='|') do
		begin
			Rating:=Rating+x;
			read(datafilm, x);
		end;
		tabDF[j].Rating:=Rating;
				
		{Durasi}		
		read(datafilm, x);
		read(datafilm, x);
		while not (x='|') do
		begin
			Durasi:=Durasi+x;
			read(datafilm, x);
		end;
		tabDF[j].Durasi:=Durasi;
				
		{SINOPSIS}		
		read(datafilm, x);
		read(datafilm, x);
		while not (x='|') do
		begin
			SINOPSIS:=SINOPSIS+x;
			read(datafilm, x);
		end;
		tabDF[j].SINOPSIS:=SINOPSIS;
		
		{HWeekDay}		
		read(datafilm, x);
		read(datafilm, x);
		while not ((x=' ')or(x='|')) do
		begin
			HWeekDay:=HWeekDay+x;
			read(datafilm,x);
		end;
		tabDF[j].HWeekDay:=StrToInt(HWeekDay);		

		{HWeekEnd}
		read(datafilm, x);
		read(datafilm, x);
		readln(datafilm, y);
		tabDF[j].HWeekEnd := StrToInt(y);
			
		j:=j+1;
		
	end;
	jumlahfilm:=j-1;
//=========================================================================================================================================================================================================
	j:=1;
	count:=0;

	while not (EOF(datajadwaltayang)) do
	begin
				
		Judul:='';
		JAM:='';
		TGL:='';
		BLN:='';
		THN:='';
		SISA:=0;
		
		{Judul}		
		read(datajadwaltayang, x);
		while not (x='|') do
		begin
			Judul:=Judul+x;
			read(datajadwaltayang, x);
		end;
		tempJudul[j]:=Judul;		
			
		{JAM}		
		read(datajadwaltayang, x);
		read(datajadwaltayang, x);
		while not  ((x='|') or (x=' ')) do
		begin
			JAM:=JAM+x;
			read(datajadwaltayang, x);
		end;
		tempJAM[j]:=JAM;		
			
		{TGL}		
		read(datajadwaltayang, x);
		read(datajadwaltayang, x);
		read(datajadwaltayang, x);
		while not ((x='|') or (x=' ')) do
		begin
			TGL:=TGL+x;
			read(datajadwaltayang, x);
		end;
		tempTGL[j]:=StrToInt(TGL);		
			
		{BLN}		
		read(datajadwaltayang, x);
		read(datajadwaltayang, x);
		read(datajadwaltayang, x);
		while not ((x='|') or (x=' ')) do
		begin
			BLN:=BLN+x;
			read(datajadwaltayang, x);
		end;
		tempBLN[j]:=StrToInt(BLN);		
			
		{THN}		
		read(datajadwaltayang, x);
		read(datajadwaltayang, x);
		read(datajadwaltayang, x);
		while not ((x='|') or (x=' ')) do
		begin
			THN:=THN+x;
			read(datajadwaltayang, x);
		end;
		tempTHN[j]:=StrToInt(THN);		
		
		{SISA}
		read(datajadwaltayang, x);
		read(datajadwaltayang, x);
		readln(datajadwaltayang, y);
		SISA := StrToInt(y);		
		
		k:=0;
		for i:=(count+1) to (count + SISA ) do
		begin
			tabDJT[i].Judul:=tempJudul[j];
			tabDJT[i].JAM:=tempJAM[j];
			tabDJT[i].TGL:=tempTGL[j]+k;
			tabDJT[i].BLN:=tempBLN[j];
			tabDJT[i].THN:=tempTHN[j];
			count:=i;
			k:=k+1;
		end;
		
		j:=j+1;
	end;
	
	for i:=1 to count do
	begin
		tabDJT[i].SISA:=0;
	end;
	
	jumlahjadwal:=count;
//=========================================================================================================================================================================================================

	j:=1;
	
	while not (EOF(datakapasitas)) do
	begin

		Judul:='';
		JAM:='';
		TGL:='';
		BLN:='';
		THN:='';
		SISA:=0;
					
		{Judul}		
		read(datakapasitas, x);
		while not (x='|') do
		begin
			Judul:=Judul+x;
			read(datakapasitas, x);
		end;
		tabDKP[j].Judul:=Judul;

		{TGL}		
		read(datakapasitas, x);
		read(datakapasitas, x);
		while not((x=' ') or (x='|')) do
		begin
			TGL:=TGL+x;
			read(datakapasitas, x);
		end;
		tabDKP[j].TGL:=StrToInt(TGL);		
		
		{BLN}		
		read(datakapasitas, x);
		read(datakapasitas, x);
		read(datakapasitas, x);
		while not((x=' ') or (x='|')) do
		begin
			BLN:=BLN+x;
			read(datakapasitas, x);
		end;
		tabDKP[j].BLN:=StrToInt(BLN);		
		
		{THN}		
		i:=1;
		read(datakapasitas, x);
		read(datakapasitas, x);
		read(datakapasitas, x);
		while not ((x=' ') or (x='|')) do
		begin
			THN:=THN+x;
			read(datakapasitas, x);
		end;
		tabDKP[j].THN:=StrToInt(THN);		
		
		{JAM}		
		read(datakapasitas, x);
		read(datakapasitas, x);
		read(datakapasitas, x);
		while not ((x='|') or (x=' ')) do
		begin
			JAM:=JAM+x;
			read(datakapasitas, x);
		end;
		tabDKP[j].JAM:=JAM;		
		
		{SISA}
		read(datakapasitas, x);
		read(datakapasitas, x);
		readln(datakapasitas, y);
		tabDKP[j].SISA:=StrToInt(y);
		
		j:=j+1;
		
	end;
		
	for i:=1 to count do
	begin
		if ((tabDJT[i].Judul=tabDKP[i].Judul) and (tabDJT[i].JAM=tabDKP[i].JAM) and (tabDJT[i].TGL=tabDKP[i].TGL) and (tabDJT[i].BLN=tabDKP[i].BLN) and (tabDJT[i].THN=tabDKP[i].THN) ) then tabDJT[i].SISA:=tabDKP[i].SISA
		else writeln('Error data kapasitas pada tanggal ',tabDJT[i].TGL,'/',tabDJT[i].BLN,'/',tabDJT[i].THN,' pukul ',tabDJT[i].JAM);
	end;
//=========================================================================================================================================================================================================
	
	j:=1;
	while not (EOF(datapemesanantiket)) do
	begin
		
		KODEBAYAR:='';
		JAM:='';
		TGL:='';
		BLN:='';
		THN:='';
		NTIKET:='';
		Judul:='';
		TOTAL:='';
		STATUS:='';
		
		{KODEBAYAR}		
		read(datapemesanantiket, x);
		while not ((x=' ') or(x='|')) do
		begin
			KODEBAYAR:=KODEBAYAR+x;
			read(datapemesanantiket, x);
		end;
		tabDPT[j].KODEBAYAR:=KODEBAYAR;		
		
		{Judul}		
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		while not (x='|') do
		begin
			Judul:=Judul+x;
			read(datapemesanantiket, x);
		end;
		tabDPT[j].Judul:=Judul;		

		{TGL}		
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		while not  ((x=' ')or(x='|')) do
		begin
			TGL:=TGL+x;
			read(datapemesanantiket, x);
		end;
		tabDPT[j].TGL:=StrToInt(TGL);		

		{BLN}	
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		while not  ((x=' ')or(x='|')) do
		begin
			BLN:=BLN+x;
			read(datapemesanantiket, x);
		end;
		tabDPT[j].BLN:=StrToInt(BLN);		
		
		{THN}		
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		while not  ((x=' ')or(x='|')) do
		begin
			THN:=THN+x;
			read(datapemesanantiket, x);
		end;
		tabDPT[j].THN:=StrToInt(THN);		

		{JAM}		
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		while not ((x=' ')or(x='|')) do
		begin
			JAM:=JAM+x;
			read(datapemesanantiket, x);
		end;
		tabDPT[j].JAM:=JAM;		
		
		{NTIKET}		
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		while not  ((x=' ')or(x='|')) do
		begin
			NTIKET:=NTIKET+x;
			read(datapemesanantiket, x);
		end;
		tabDPT[j].NTIKET:=StrToInt(NTIKET);		
			
		{TOTAL}		
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		while not  ((x=' ')or(x='|')) do
		begin
			TOTAL:=TOTAL+x;
			read(datapemesanantiket, x);
		end;
		tabDPT[j].TOTAL:=StrToInt(TOTAL);		
		
		{STATUS}		
		read(datapemesanantiket, x);
		read(datapemesanantiket, x);
		readln(datapemesanantiket, tabDPT[j].STATUS);		
		
		j:=j+1;
		
	end;
	jumlahpemesanan:=j-1;
//=========================================================================================================================================================================================================
	Username:='';
	PASSWORD:='';
	SALDO:='';
	j:=1;
	while not (EOF(datamember)) do
	begin
		
		{Username}		
		read(datamember, x);
		while not ((x=' ') or (x='|')) do
		begin
			Username:=Username+x;
			read(datamember, x);
		end;
		tabDM[j].Username:=Username;		
		
		{PASSWORD}		
		read(datamember, x);
		read(datamember, x);
		read(datamember, x);
		while not ((x='|') or (x=' ')) do
		begin
			PASSWORD:=PASSWORD+x;
			read(datamember, x);
		end;
		tabDM[j].PASSWORD:=PASSWORD;		

		{SALDO}
		read(datamember, x);
		read(datamember, x);
		readln(datamember, y);
		tabDM[j].SALDO:=StrToInt(y);		
		
		j:=j+1;
		
	end;
	jumlahmember:=j-1;
//=========================================================================================================================================================================================================
	TGL:='';
	BLN:='';
	THN:='';
	
	while not (EOF(datahariini)) do
	begin
		
		{TGL}		
		read(datahariini, x);
		while not ((x='|') or (x=' ')) do
		begin
			TGL:=TGL+x;
			read(datahariini, x);
		end;
		hariini.TGL:=StrToInt(TGL);		
		
		{BLN}		
		read(datahariini, x);
		read(datahariini, x);
		read(datahariini, x);
		while not ((x=' ') or (x='|')) do
		begin
			BLN:=BLN+x;
			read(datahariini, x);
		end;
		hariini.BLN:=StrToInt(BLN);		
		
		{THN}		
		read(datahariini, x);
		read(datahariini, x);
		read(datahariini, x);
		while not ((x=' ') or (x='|')) do
		begin
			THN:=THN+x;
			read(datahariini, x);
		end;
		hariini.THN:=StrToInt(THN);		

		{HARI}		
		read(datahariini, x);
		read(datahariini, x);
		readln(datahariini, y);
		hariini.HARI:=y;		
		
	end;
//=========================================================================================================================================================================================================
	
	Close( datafilm);
	Close( datajadwaltayang);
	Close( datakapasitas);
	Close( datapemesanantiket);
	Close( datamember);
	Close( datahariini);
	
//=========================================================================================================================================================================================================
end;

end.
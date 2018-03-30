CREATE PROCEDURE [dbo].[SPc_EncriptaPassword]
@sPassword	varchar(10), 
@sRegresa 	varchar (20) output
--Encriptacion
-- --TOREO\n-- WITH ENCRYPTION 
as
SET NOCOUNT ON


Declare @iRegresa	Decimal(18,0),
	@iContador	int,
	@strCadena	varchar(50),
	@Bandera	int,
	@Mitad		int,
	@vA		int,
	@vB		int,
	@vC		int,
	@vD		int,
	@vE		int,
	@vF		int,
	@Res1		int,
	@Res2		int,
	@Res3		int

select @iRegresa    = 0, @iContador = 1

select @sRegresa = '', @strCadena = ''


while @iContador <= len(ltrim(rtrim(@sPassword)))
begin
	select @strCadena = ltrim(rtrim(@strCadena)) + ltrim(rtrim(convert(varchar(10),isnull(Len(Ascii(substring(@sPassword,@iContador,1))*@iContador),0))) +
			ltrim(rtrim(convert(varchar(10),isnull((ascii(substring(@sPassword,@iContador,1)) * @iContador),0)))))

	select @iContador = @iContador + 1
end


Select @iContador = 0, @Bandera = 0

while @iContador = 0
begin
	while @Bandera = 0
	begin
		If Len(@StrCadena)%6 = 0
		Begin
			Select @Mitad = Len(@StrCadena)/6
			Select @Bandera = 1
		End
		Else
		Begin			
			Select @StrCadena = ltrim(rtrim(@StrCadena)) + '0'
		End
	End

	Select @vA = Convert(Int, SubString(@StrCadena, 1, @Mitad))
	Select @vB = Convert(Int, SubString(@StrCadena, @Mitad+1, @Mitad))
	Select @vC = Convert(Int, SubString(@StrCadena, (@Mitad*2)+1, @Mitad))		
	Select @vD = Convert(Int, SubString(@StrCadena, (@Mitad*3)+1, @Mitad))		
	Select @vE = Convert(Int, SubString(@StrCadena, (@Mitad*4)+1, @Mitad))		
	Select @vF = Convert(Int, SubString(@StrCadena, (@Mitad*5)+1, @Mitad))

	Select @Res1 = @vA ^ @vD
	Select @Res2 = @vB ^ @vE
	Select @Res3 = @vC ^ @vF

	Select @StrCadena = Convert(VarChar(10),@Res1) + Convert(VarChar(10),@Res2) + Convert(VarChar(10),@Res3)
	
	If Len(rtrim(ltrim(@StrCadena))) <= 10
	Begin
		Select @iRegresa = Convert(Decimal(18,0), @StrCadena)
		Select @iContador = 1
	End
	Else
		Select @Bandera = 0
end
Select @iRegresa = Convert(Decimal(18,0), @StrCadena)
Select @sRegresa = Convert(Varchar(20),@iRegresa)
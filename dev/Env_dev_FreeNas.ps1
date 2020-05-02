Function New-banner{
    #
    #requires -version 4
    <#
    .SYNOPSIS
        Convertto-TextASCIIArt converts text string to ASCII Art.
    .DESCRIPTION
        The Convertto-TextASCIIArt show normal string or text as big font nicely on console. I have created one font for use (It is not exactly font but background color and cannot be copied), alternatively if you are using online parameter it will fetch more fonts online from 'http://artii.herokuapp.com'.
    .PARAMETER Text
        This is common parameter for inbuilt and online and incase not provided default value is '# This is test !', If you are using inbuilt font small letter will convert to capital letter.
    .PARAMETER Online
        To use this parameter make sure you have active internet connection, as it will connect to website http://artii.herokuapp.com and and using api it will download the acsii Art
    .PARAMETER FontName
        There are wide variaty of font list available on http://artii.herokuapp.com/fonts_list, when using online parameter, Value provided here is case sensetive.
    .PARAMETER FontColor
        Below is the list of font color can be used to show ascii art.
        'Black', 'DarkBlue','DarkGreen','DarkCyan', 'DarkRed','DarkMagenta','DarkYellow','Gray','DarkGray','Blue','Green','Cyan','Red','Magenta','Yellow','White'
    .PARAMETER FontHight
        This parameter is optional and default value is 5, this is font hight and required for the font I created. Algorithm of this script is depend on the default value.
    .INPUTS
        [System.String]
    .OUTPUTS
        [console]
    .NOTES
        Version:        1.0
        Author:         Kunal Udapi
        Creation Date:  30 September 2017
        Purpose/Change: Personal use to show text to ascii art.
        Useful URLs: http://vcloud-lab.com, http://artii.herokuapp.com/fonts_list
    .EXAMPLE
        PS C:\>.\Convertto-TextASCIIArt -Online -Text "http://vcloud-lab.com" -FontColor Gray -Fontname big
      _     _   _              ____         _                 _        _       _                         
     | |   | | | |       _    / / /        | |               | |      | |     | |                        
     | |__ | |_| |_ _ __(_)  / / /_   _____| | ___  _   _  __| |______| | __ _| |__   ___ ___  _ __ ___  
     | '_ \| __| __| '_ \   / / /\ \ / / __| |/ _ \| | | |/ _` |______| |/ _` | '_ \ / __/ _ \| '_ ` _ \ 
     | | | | |_| |_| |_) | / / /  \ V / (__| | (_) | |_| | (_| |      | | (_| | |_) | (__ (_) | | | | | |
     |_| |_|\__|\__| .__(_)_/_/    \_/ \___|_|\___/ \__,_|\__,_|      |_|\__,_|_.__(_)___\___/|_| |_| |_|
                   | |                                                                                   
                   |_|                                                                                   
    
        Shows and converts text to cool ascii art from online site http://artii.herokuapp.com using apis.
    .EXAMPLE
        PS C:\>.\Convertto-TextASCIIArt -Text '# This !'
    
          ��  ��     ������ ��  �� ��   ����     ��
        ����������     ��   ��  �� �� ��         ��  
          ��  ��       ��   ������ ��   ��       ��  
        ����������     ��   ��  �� ��     ��    
          ��  ��       ��   ��  �� �� ����       ��  
        
        Shows local font on the script not internet required
    #>
    
    [CmdletBinding(SupportsShouldProcess=$True,
        ConfirmImpact='Medium',
        HelpURI='http://vcloud-lab.com',
        DefaultParameterSetName='Inbuilt')]
    Param
    (
        [parameter(Position=0, ParameterSetName='Inbuilt', ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true, HelpMessage='Provide valid text')]
        [parameter(Position=0, ParameterSetName='Online', ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true, HelpMessage='Provide valid text')]
        [string]$Text = '# This is test !',
        [parameter(Position=2, ParameterSetName='Inbuilt', ValueFromPipelineByPropertyName=$true, HelpMessage='Provide existing font hight')]
        [Alias('Hight')]    
        [string]$FontHight = '5',
        
        [parameter(Position=2, ParameterSetName='Online', ValueFromPipelineByPropertyName=$true, HelpMessage='Provide font name list is avaliable on http://artii.herokuapp.com/fonts_list')]
        [ValidateSet('3-d','3x5','5lineoblique','1943____','4x4_offr','64f1____','a_zooloo','advenger','aquaplan','asc_____','ascii___','assalt_m','asslt__m','atc_____','atc_gran','b_m__200','battle_s','battlesh','baz__bil','beer_pub','bubble__','bubble_b','c1______','c2______','c_ascii_','c_consen','caus_in_','char1___','char2___','char3___','char4___','charact1','charact2','charact3','charact4','charact5','charact6','characte','charset_','coil_cop','com_sen_','computer','convoy__','d_dragon','dcs_bfmo','deep_str','demo_1__','demo_2__','demo_m__','devilish','druid___','e__fist_','ebbs_1__','ebbs_2__','eca_____','etcrvs__','f15_____','faces_of','fair_mea','fairligh','fantasy_','fbr12___','fbr1____','fbr2____','fbr_stri','fbr_tilt','finalass','fireing_','flyn_sh','fp1_____','fp2_____','funky_dr','future_1','future_2','future_3','future_4','future_5','future_6','future_7','future_8','gauntlet','ghost_bo','gothic','gothic__','grand_pr','green_be','hades___','heavy_me','heroboti','high_noo','hills___','home_pak','house_of','hypa_bal','hyper___','inc_raw_','italics_','joust___','kgames_i','kik_star','krak_out','lazy_jon','letter_w','letterw3','lexible_','mad_nurs','magic_ma','master_o','mayhem_d','mcg_____','mig_ally','modern__','new_asci','nfi1____','notie_ca','npn_____','odel_lak','ok_beer_','outrun__','p_s_h_m_','p_skateb','pacos_pe','panther_','pawn_ins','phonix__','platoon2','platoon_','pod_____','r2-d2___','rad_____','rad_phan','radical_','rainbow_','rally_s2','rally_sp','rampage_','rastan__','raw_recu','rci_____','ripper!_','road_rai','rockbox_','rok_____','roman','roman___','script__','skate_ro','skateord','skateroc','sketch_s','sm______','space_op','spc_demo','star_war','stealth_','stencil1','stencil2','street_s','subteran','super_te','t__of_ap','tav1____','taxi____','tec1____','tec_7000','tecrvs__','ti_pan__','timesofl','tomahawk','top_duck','trashman','triad_st','ts1_____','tsm_____','tsn_base','twin_cob','type_set','ucf_fan_','ugalympi','unarmed_','usa_____','usa_pq__','vortron_','war_of_w','yie-ar__','yie_ar_k','z-pilot_','zig_zag_','zone7___','acrobatic','alligator','alligator2','alphabet','avatar','banner','banner3-D','banner3','banner4','barbwire','basic','5x7','5x8','6x10','6x9','brite','briteb','britebi','britei','chartr','chartri','clb6x10','clb8x10','clb8x8','cli8x8','clr4x6','clr5x10','clr5x6','clr5x8','clr6x10','clr6x6','clr6x8','clr7x10','clr7x8','clr8x10','clr8x8','cour','courb','courbi','couri','helv','helvb','helvbi','helvi','sans','sansb','sansbi','sansi','sbook','sbookb','sbookbi','sbooki','times','tty','ttyb','utopia','utopiab','utopiabi','utopiai','xbrite','xbriteb','xbritebi','xbritei','xchartr','xchartri','xcour','xcourb','xcourbi','xcouri','xhelv','xhelvb','xhelvbi','xhelvi','xsans','xsansb','xsansbi','xsansi','xsbook','xsbookb','xsbookbi','xsbooki','xtimes','xtty','xttyb','bell','big','bigchief','binary','block','broadway','bubble','bulbhead','calgphy2','caligraphy','catwalk','chunky','coinstak','colossal','contessa','contrast','cosmic','cosmike','crawford','cricket','cursive','cyberlarge','cybermedium','cybersmall','decimal','diamond','digital','doh','doom','dotmatrix','double','drpepper','dwhistled','eftichess','eftifont','eftipiti','eftirobot','eftitalic','eftiwall','eftiwater','epic','fender','fourtops','fraktur','goofy','graceful','gradient','graffiti','hex','hollywood','invita','isometric1','isometric2','isometric3','isometric4','italic','ivrit','jazmine','jerusalem','katakana','kban','l4me','larry3d','lcd','lean','letters','linux','lockergnome','madrid','marquee','maxfour','mike','mini','mirror','mnemonic','morse','moscow','mshebrew210','nancyj-fancy','nancyj-underlined','nancyj','nipples','ntgreek','nvscript','o8','octal','ogre','os2','pawp','peaks','pebbles','pepper','poison','puffy','pyramid','rectangles','relief','relief2','rev','rot13','rounded','rowancap','rozzo','runic','runyc','sblood','script','serifcap','shadow','short','slant','slide','slscript','small','smisome1','smkeyboard','smscript','smshadow','smslant','smtengwar','speed','stacey','stampatello','standard','starwars','stellar','stop','straight','tanja','tengwar','term','thick','thin','threepoint','ticks','ticksslant','tinker-toy','tombstone','trek','tsalagi','twopoint','univers','usaflag','weird','whimsy')]
        [Alias('Font')]
        [string]$FontName = 'big',
    
        [parameter(ParameterSetName = 'Online', Position=0, Mandatory=$false)]
        [Switch]$Online,
    
        [parameter(Position=1, ParameterSetName='Inbuilt', ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true, HelpMessage='Provide valid console color')]
        [parameter(ParameterSetName = 'Online', Position=1, Mandatory=$false, HelpMessage='Provide valid console color')]  
        [Alias('Color')]
        [ValidateSet('Black', 'DarkBlue','DarkGreen','DarkCyan', 'DarkRed','DarkMagenta','DarkYellow','Gray','DarkGray','Blue','Green','Cyan','Red','Magenta','Yellow','White')]
        [string]$FontColor = 'Yellow'
    )
    Begin {
        #$NonExistFont = $null
        if ($PsCmdlet.ParameterSetName -eq 'Inbuilt') {
            $a = {<#a 07#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#a#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor  -NoNewline; Write-Host " "
            <#a#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor  -NoNewline; Write-Host " "
            <#a#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#a#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor  -NoNewline; Write-Host " "} 
            $b = {<#b 07#> Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 3) 
            <#b#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor   -NoNewline; Write-Host " "
            <#b#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#b#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor  -NoNewline; Write-Host " "
            <#b#> Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 3) } 
            $c = {<#c 07#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#c#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4) 
            <#c#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4)
            <#c#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4)
            <#c#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $d = {<#d 07#> Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 3)
            <#d#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#d#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#d#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#d#> Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 3)}  
            $e = {<#e 06#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#e#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4)
            <#e#> Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host "  " 
            <#e#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4)
            <#e#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $f = {<#f 07#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#f#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4)
            <#f#> Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host "  "
            <#f#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4)
            <#f#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4)}
            $g = {<#g 07#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#g#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 5)
            <#g#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host " " -NoNewline -BackgroundColor $FontColor; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#g#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#g#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $h = {<#h 07#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#h#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#h#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#h#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#h#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $i = {<#i 03#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#i#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "  
            <#i#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#i#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#i#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $j = {<#j 07#> Write-Host "  " -NoNewline; Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#j#> Write-Host $(" " * 4) -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host " "  
            <#j#> Write-Host $(" " * 4) -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host " " 
            <#h#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#j#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $k = {<#k 09#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#k#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host " " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)
            <#k#> Write-Host $(" " * 3) -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 5)
            <#k#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host " " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)
            <#k#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $l = {<#l 05#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host "  " -NoNewline; Write-Host " "
            <#l#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)
            <#l#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)
            <#l#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)
            <#l#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $m = {<#m 09#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#m#> Write-Host $(" " * 3) -NoNewline -BackgroundColor $FontColor; Write-Host "  " -NoNewline; Write-Host $(" " * 3) -NoNewline -BackgroundColor $FontColor; Write-Host " "
            <#m#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host " " -NoNewline ; Write-Host "  " -NoNewline -BackgroundColor $FontColor ; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#m#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#m#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $n = {<#n 09#> Write-Host $(" " * 3) -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#n#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host " " -NoNewline; Write-Host " " -NoNewline -BackgroundColor $FontColor; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#n#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host "  " -NoNewline; Write-Host " " -NoNewline -BackgroundColor $FontColor ; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#n#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3) -NoNewline; Write-Host " " -NoNewline -BackgroundColor $FontColor; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#n#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $o = {<#o 07#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#o#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#o#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#o#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#o#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $p = {<#p 07#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#p#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#p#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#p#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 5) 
            <#p#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 5)}
            $q = {<#q 09#> Write-Host "  " -NoNewline; Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 3)
            <#q#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#q#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#q#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)
            <#q#> Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $r = {<#r 07#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#r#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#r#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#r#> Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 3)
            <#r#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $s = {<#s 07#> Write-Host "  " -NoNewline; Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#s#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 5)
            <#s#> Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)
            <#s#> Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#s#> Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host " "}
            $t = {<#t 07#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#t#> Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)
            <#t#> Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)
            <#t#> Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3) 
            <#t#> Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)}
            $u = {<#u 07#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#u#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#u#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#u#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#u#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $v = {<#v 11#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 6) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#v#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 6) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#v#> Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  "
            <#v#> Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3)
            <#v#> Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 5)}
            $w = {<#W 09#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host  $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#W#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host  $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#W#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline ; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#W#> Write-Host $(" " * 3) -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host $(" " * 3) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#W#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host  $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $x = {<#x 09#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#x#> Write-Host " " -NoNewline ; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host "  " 
            <#x#> Write-Host $(" " * 3) -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 4) 
            <#x#> Write-Host " " -NoNewline ; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host "  " 
            <#x#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $y = {<#y 11#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#y#> Write-Host " " -NoNewline;  Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  "
            <#y#> Write-Host $(" " * 3) -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 4) 
            <#y#> Write-Host $(" " * 3) -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 4) 
            <#y#> Write-Host $(" " * 3) -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 4)}
            $z = {<#z 07#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#z#> Write-Host $(" " * 4) -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor ; Write-Host " " 
            <#z#> Write-Host "  " -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 3) 
            <#z#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 5)
            <#z#> Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $hyphen = {<#- 05#> Write-Host $(" " * 5)
            <#-#> Write-Host $(" " * 5)
            <#-#> Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#-#> Write-Host $(" " * 5)
            <#-#> Write-Host $(" " * 5)}
            $Hash = {<## 11#> Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host (" " * 3)
            <###> Write-Host $(" " * 10) -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <###> Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host (" " * 3)
            <###> Write-Host $(" " * 10) -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <###> Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host (" " * 3)}
            $AtRate = {<#@ 09#> Write-Host " " -NosNewline; Write-Host $(" " * 6) -BackgroundColor $FontColor -NoNewline; Write-Host "  "
            <#@#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host (" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#@#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host " " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#@#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  " -NoNewline; Write-Host " " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#@#> Write-Host " " -NoNewline; Write-Host $(" " * 4) -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline;  Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $Exlaim = {<#! 03#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#!#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "  
            <#!#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#!#> Write-Host $(" " * 3)
            <#!#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $Dot = {<#. 03#> Write-Host $(" " * 3)
            <#.#> Write-Host $(" " * 3)  
            <#.#> Write-Host $(" " * 3) 
            <#.#> Write-Host $(" " * 3)
            <#.#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $Forward = {<#. 07#> Write-Host $(" " * 4) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#/#> Write-Host $(" " * 3) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host "  "
            <#/#> Write-Host "  " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 3)
            <#/#> Write-Host $(" " * 1) -NoNewline ; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4)
            <#/#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 5)}
            $Colun = {<#: 03#> Write-Host $(" " * 3)
            <#:#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#:#> Write-Host $(" " * 3)  
            <#:#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#:#> Write-Host $(" " * 3)}
            $Space = {<#  02#> Write-Host $(" " * 2)
            <# #> Write-Host $(" " * 2)
            <# #> Write-Host $(" " * 2)
            <# #> Write-Host $(" " * 2)
            <# #> Write-Host $(" " * 2)}
            $1 = {<#1 04#> Write-Host $(" " * 3) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#1 #> Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#1 #> Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#1 #> Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#1 #> Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $2 = {<#2 06#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#2#> Write-Host $(" " * 3) -NoNewline; Write-Host "  " -NoNewline -BackgroundColor $FontColor ; Write-Host " " 
            <#z#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#z#> Write-Host "  " -NoNewline -BackgroundColor $FontColor; Write-Host $(" " * 4)
            <#z#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $3 = {<#3 06#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#3#> Write-Host $(" " * 3) -NoNewline;  Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#3#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#3#> Write-Host $(" " * 3) -NoNewline;  Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#3#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $4 = {<#4 06#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#4#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#4#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#4#> Write-Host $(" " * 3) -NoNewline;  Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#4#> Write-Host $(" " * 3) -NoNewline;  Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $5 = {<#5 06#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#s#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4)
            <#s#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#s#> Write-Host $(" " * 3) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#s#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $6 = {<#6 06#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#6#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host $(" " * 4)
            <#6#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#6#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#6#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $7 = {<#7 06#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#7#> Write-Host $(" " * 3) -NoNewline;  Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#7#> Write-Host $(" " * 3) -NoNewline;  Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#7#> Write-Host $(" " * 3) -NoNewline;  Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#7#> Write-Host $(" " * 3) -NoNewline;  Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $8 = {<#8 06#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#8#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#8#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#8#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#8#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $9 = {<#9 06#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#9#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#9#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "
            <#9#> Write-Host $(" " * 3) -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#9#> Write-Host $(" " * 5) -BackgroundColor $FontColor -NoNewline; Write-Host " "}
            $0 = {<#0 06#> Write-Host " " -NoNewline ;Write-Host $(" " * 3) -BackgroundColor $FontColor -NoNewline; Write-Host "  "
            <#0#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#0#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#0#> Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " -NoNewline; Write-Host "  " -BackgroundColor $FontColor -NoNewline; Write-Host " " 
            <#0#> Write-Host " " -NoNewline; Write-Host $(" " * 3) -BackgroundColor $FontColor -NoNewline; Write-Host "  "}
        }#if
    }
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            'Inbuilt' {    
                [char[]]$AllCharacters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
                foreach ($singleChar in $AllCharacters) {
                    $CharScript = Get-Variable -Name $singleChar | Select-Object -ExpandProperty Value
                    $CharScript = ($CharScript -split "`r`n")
                    New-Variable -Name $singleChar -Value $CharScript -Force
                }
                $hyphen = $hyphen -split "`r`n"
                $Hash = $Hash -split "`r`n"
                $AtRate = $AtRate -split "`r`n"
                $Exlaim = $Exlaim -split "`r`n"
                $Dot = $Dot -split "`r`n"
                $Forward = $Forward -split "`r`n"
                $Colun = $Colun -split "`r`n"
                $Space = $Space -split "`r`n"
    
                $textlength = $text.Length 
                [char[]]$TextBreakDown = $text 
      
                $wordart = @() 
                $FindWidth  = @()
                $NonExistFont = @()
    
                for ($ind= 0; $ind -lt $FontHight; $ind++) { 
                    $Conf = 1 
                    foreach ($character in $TextBreakDown) { 
                        $NoFont = $True
                        Switch -regex ($character) {
                            '-' {
                                $charname =  Get-Variable -Name hyphen
                                break
                            } #-
                            '#' {
                                $charname =  Get-Variable -Name Hash
                                break
                            } ##
                            '@' {
                                $charname =  Get-Variable -Name AtRate
                                break
                            } #-
                            '!' {
                                $charname =  Get-Variable -Name Exlaim
                                break
                            } #!
                            '\.' {
                                $charname =  Get-Variable -Name Dot
                                break
                            } #.
                            ':' {
                                $charname =  Get-Variable -Name Colun
                                break
                            } #.
                            '/' {
                                $charname =  Get-Variable -Name Forward
                                break
                            } #.
                            '\s' {
                                $charname =  Get-Variable -Name space
                                break
                            } #.
                            "[A-Za-z_0-9]" {
                                $charname = Get-Variable -Name $character
                                break
                            } 
                            default {
                                $NoFont = $false
                                break
                            } #default
                        } #switch
                    
                        if ($NoFont -eq $True) {
                            if ($Conf -eq $textlength) { 
                                $info = $charname.value[$ind] 
                                $wordart += $info
                            } #if conf
                            else {
                                $info = $charname.value[$ind] 
                                $wordart += "{0} {1}" -f $info, '-NoNewLine'
                            } #else conf
                            $wordart += "`r`n"
                    
                            #Get First Line to calculate width
                            if ($ind -eq 0) {
                                $FindWidth += $charname.value[$ind]
                            } #if ind
                    
                            #Calculate font width
                            if ($ind -eq 0) {
                                $AllFirstLines = @()
                                $FindWidth = $FindWidth.trim() | Where-Object {$_ -ne ""}
                                $CharWidth = $FindWidth | foreach {$_.Substring(4,2)}
                                $BigFontWidth = $CharWidth | Measure-Object -Sum | Select-Object -ExpandProperty Sum
                            } #if ind
    
                        } #if NoFont
                        else {
                            $NonExistFont += $character
                        } #else NoFont
                        $Conf++
                    } #foreach character
                } #for
                $TempFilePath = [System.IO.Path]::GetTempPath()
                $TempFileName = "{0}{1}" -f $TempFilePath, 'Show-BigFontOnConsole.ps1'
                $wordart | foreach {$_.trim()} | Out-File $TempFileName
                & $TempFileName
                if ($NonExistFont -ne $null) {
                    $NonExistFont = $NonExistFont | Sort-Object | Get-Unique
                    $NonResult = $NonExistFont -join " "
                    Write-Host "`n`nSkipping as, No ascii fonts found for $NonResult" -BackgroundColor DarkRed
                } # if NonExistFont
            } #Inbuilt
            'Online' {
                if ($text -eq '# This is test !') {
                    $text = 'http://vcloud-lab.com'
                }
                $testEncode = [uri]::EscapeDataString($Text)
                $url = "http://artii.herokuapp.com/make?text=$testEncode&font=$FontName"
                Try {
                    $WebsiteApi = Invoke-WebRequest -Uri $url -ErrorAction Stop
                    Write-Host $WebsiteApi.Content -ForegroundColor $FontColor
                }
                catch {
                    $errMessage = "Check your internet connection, Verify below url in browser`n"
                    $errMessage += $url
                    Write-Error $errMessage
                }
            } #Online
        } #switch pscmdlet
    }
    end {
    }
    
    }
function Set-FreeNasCipherSSL {

    # Hack for allowing TLS 1.1 and TLS 1.2 (by default it is only SSL3 and TLS (1.0))
    $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
    [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols

}
function Set-FreeNasUntrustedSSL
{

    # Hack for allowing untrusted SSL certs with https connections
    Add-Type -TypeDefinition @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@

    [System.Net.ServicePointManager]::CertificatePolicy = New-Object -TypeName TrustAllCertsPolicy

}

function Show-FreeNasException() {
    Param(
        [parameter(Mandatory = $true)]
        $Exception
    )

    #Check if certificate is valid
    if ($Exception.Exception.InnerException) {
        $exceptiontype = $Exception.Exception.InnerException.GetType()
        if ("AuthenticationException" -eq $exceptiontype.name) {
            Write-Warning "Invalid certificat (Untrusted, wrong date, invalid name...)"
            Write-Warning "Try to use Connect-FreeNasServer -SkipCertificateCheck for connection"
            throw "Unable to connect (certificate)"
        }
    }

    If ($Exception.Exception.Response) {
        if ("Desktop" -eq $PSVersionTable.PSEdition) {
            $result = $Exception.Exception.Response.GetResponseStream()
            $reader = New-Object -TypeName System.IO.StreamReader($result)
            $responseBody = $reader.ReadToEnd()
            $responseJson =  $responseBody | ConvertFrom-Json
        }

        Write-Warning "The FreeNas  API sends an error message:"
        Write-Warning "Error description (code): $($Exception.Exception.Response.StatusDescription) ($($Exception.Exception.Response.StatusCode.Value__))"
        if ($responseBody) {
            if ($responseJson.message) {
                Write-Warning "Error details: $($responseJson.message)"
            }
            else {
                Write-Warning "Error details: $($responseBody)"
            }
        }
        elseif ($Exception.ErrorDetails.Message) {
            Write-Warning "Error details: $($Exception.ErrorDetails.Message)"
        }
    }
}
<#
      .SYNOPSIS
      Connect FreeNas Server it use to connect to your FreeNas Server or TrueNas

      .DESCRIPTION
      Connect FreeNas Server it use to connect to your FreeNas Server or TrueNas
      Support connection to HTTPS (default) or HTTP

      .EXAMPLE
      Connect-FreeNasServer -Server 192.0.2.1

      Connect to an FreeNas using HTTPS with IP 192.0.2.1 using (Get-)credential

      .EXAMPLE
      Connect-FreeNasServer -Server 192.0.2.1 -SkipCertificateCheck

      Connect to an FreeNas using HTTPS (without check certificate validation) with IP 192.0.2.1 using (Get-)credential

      .EXAMPLE
      Connect-FreeNasServer -Server 192.0.2.1 -httpOnly

      Connect to an FreeNas using HTTP (unsecure !) with IP 192.0.2.1 using (Get-)credential

      .EXAMPLE
      Connect-FreeNasServer -Server 192.0.2.1 -port 4443

      Connect to an FreeNas using HTTPS (with port 4443) with IP 192.0.2.1 using (Get-)credential

      .EXAMPLE
      $cred = get-credential
      PS > Connect-FreeNasServer -Server 192.0.2.1 -credential $cred

      Connect to an FreeNas with IP 192.0.2.1 and passing (Get-)credential

      .EXAMPLE
      $mysecpassword = ConvertTo-SecureString mypassword -AsPlainText -Force
      PS > Connect-FreeNasServer -Server 192.0.2.1 -Username root -Password $mysecpassword

      Connect to an FreeNas with IP 192.0.2.1 using Username and Password

      .NOTES
      By default the connection use the secure method to interact with FreeNas or TrueNas server

      .FUNCTIONALITY
      Use this command at the begining for established the connection to your FreeNas or TrueNas server
      #>
function Connect-FreeNasServer
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param
    (
        # Description d’aide Freenas
        [Parameter(Mandatory = $true)]

        [Alias("Freenas")]
        $Server,
        [Parameter(Mandatory = $false)]
        [String]$Username,
        [Parameter(Mandatory = $false)]
        [SecureString]$Password,
        [Parameter(Mandatory = $false)]
        [PSCredential]$Credentials,
        [Parameter(Mandatory = $false)]
        [switch]$httpOnly = $false,
        [Parameter(Mandatory = $false)]
        [switch]$SkipCertificateCheck = $false,
        [Parameter(Mandatory = $false)]
        [ValidateRange(1, 65535)]
        [int]$port
    )

    Begin
    {
        Try
        {
            New-banner -Text "FreeNas 2.0" -Online -ErrorAction stop
        }
        Catch
        {
            New-banner -Text "FreeNas 2.0"
        }

    }
    Process
    {
        $Script:SrvFreenas = $Server


        #If there is a password (and a user), create a credentials
        if ($Password)
        {
            $Credentials = New-Object -TypeName System.Management.Automation.PSCredential($Username, $Password)
        }
        #Not Credentials (and no password)
        if ($NULL -eq $Credentials)
        {
            $Credentials = Get-Credential -Message 'Please enter administrative credentials for your FreeNas'
        }
        $cred = $Credentials.username + ":" + $Credentials.GetNetworkCredential().Password
        $base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($cred))
        #headers, We need to have Content-type set to application/json...
        $script:headers = @{ Authorization = "Basic " + $base64; "Content-type" = "application/json" }
        $script:invokeParams = @{ UseBasicParsing = $true; SkipCertificateCheck = $SkipCertificateCheck }

        if ("Desktop" -eq $PSVersionTable.PsEdition)
        {
            #Remove -SkipCertificateCheck from Invoke Parameter (not supported <= PS 5)
            $invokeParams.remove("SkipCertificateCheck")
        }

        if ($httpOnly)
        {
            if (!$port)
            {
                $port = 80
            }

            $uri = "http://${Server}:${port}/api/v1.0/system/version/"
        }
        else
        {
            if (!$port)
            {
                $port = 443
            }
            #for PowerShell (<=) 5 (Desktop), Enable TLS 1.1, 1.2 and Disable SSL chain trust
            if ("Desktop" -eq $PSVersionTable.PsEdition)
            {
                Write-Verbose -Message "Desktop Version try to Enable TLS 1.1 and 1.2"
                #Enable TLS 1.1 and 1.2
                Set-FreeNasCipherSSL
                if ($SkipCertificateCheck)
                {
                    Write-Verbose -Message "Disable SSL chain trust"

                    #Disable SSL chain trust...
                    Set-FreeNasuntrustedSSL
                }

            }
            $uri = "https://${Server}:${port}/api/v1.0/system/version/"
        }

        $script:port = $port
        $script:httpOnly = $httpOnly

        try
        {
            $result = Invoke-RestMethod -Uri $uri -Method Get -SessionVariable Freenas_S -headers $headers @invokeParams
        }
        catch
        {
            Show-FreeNasException -Exception $_
            throw "Unable to connect"
        }

        if ($null -eq $result.fullversion )
        {
            throw "Unable to get data"
        }

        Write-Host "Welcome on"$result.name"-"$result.fullversion""

        $Script:Session = $Freenas_S


    }
    End
    {

    }
}
<#
      .SYNOPSIS
      This function return Certificate created on your FreeNas Server
      .DESCRIPTION
      This function return Certificate created on your FreeNas Server
      .EXAMPLE
       PS C:\> Get-FreeNasCertificate

        Name              : FreeNas
        Id                : 1
        CSR               :
        DN                : /C=US/ST=US/L=New York/O=JM2K69/CN=FreeNas/emailAddress=Freenas@JM2K69.it
        Certificate       : -----BEGIN CERTIFICATE-----
                          MIIDhDCCAmygAwIBAgIEAMoKjzANBgkqhkiG9w0BAQsFADBzMQswCQYDVQQGEwJV
                          UzELMAkGA1UE..........
                          -----END CERTIFICATE-----
        Chain             : False
        City              : New York
        Common            : FreeNas
        Country           : US
        Disgest Algorithm : SHA256
        Email             : Freenas@JM2K69.loc
        From              : Thu Oct 24 05:37:47 2019
        Issuer            : CAInternal
        Key Lenght        : 2048
        Lifetime          : 3650
        Organization      : JM2K69
        PrivateKey        : -----BEGIN PRIVATE KEY-----
                            MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCzO8EZwwvleN32
                            XO/mrAYrxfhDpjY+..........
                            -----END PRIVATE KEY-----

        Serial            : 13240975
        State             : US
        Type              : 16
        Type CSR          : False
        Type CSR existing : False
        Type Internal     : True
        Valid until       : Sun Oct 21 05:37:47 2029
        .NOTES
      This command allow to find all certificate created on your FreeNas or TrueNas server

      .FUNCTIONALITY
      Use this command when you want to enable Https on your FreeNas or TrueNas server
      #>

function Get-FreeNasCertificate
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()


    Begin
    { }
    Process
    {
        $Uri = "/api/v1.0/system/certificate/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

        $Certificate = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.count)
        {

            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.cert_name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "CSR" -Value "$($result.cert_CSR)"
            $temp | Add-Member -MemberType NoteProperty -Name "DN" -Value "$($result.cert_DN)"
            $temp | Add-Member -MemberType NoteProperty -Name "Certificate" -Value "$($result.cert_certificate)"
            $temp | Add-Member -MemberType NoteProperty -Name "Chain" -Value "$($result.cert_chain)"
            $temp | Add-Member -MemberType NoteProperty -Name "City" -Value "$($result.cert_city)"
            $temp | Add-Member -MemberType NoteProperty -Name "Common" -Value "$($result.cert_common)"
            $temp | Add-Member -MemberType NoteProperty -Name "Country" -Value "$($result.cert_country)"
            $temp | Add-Member -MemberType NoteProperty -Name "Disgest Algorithm" -Value "$($result.cert_digest_algorithm)"
            $temp | Add-Member -MemberType NoteProperty -Name "Email" -Value "$($result.cert_email)"
            $temp | Add-Member -MemberType NoteProperty -Name "From" -Value "$($result.cert_from)"
            $temp | Add-Member -MemberType NoteProperty -Name "Issuer" -Value "$($result.cert_issuer)"
            $temp | Add-Member -MemberType NoteProperty -Name "Key Lenght" -Value "$($result.cert_key_length)"
            $temp | Add-Member -MemberType NoteProperty -Name "Lifetime" -Value "$($result.cert_lifetime)"
            $temp | Add-Member -MemberType NoteProperty -Name "Organization" -Value "$($result.cert_organization)"
            $temp | Add-Member -MemberType NoteProperty -Name "PrivateKey" -Value "$($result.cert_privatekey)"
            $temp | Add-Member -MemberType NoteProperty -Name "Serial" -Value "$($result.cert_serial)"
            $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result.cert_state)"
            $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result.cert_type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Type CSR" -Value "$($result.cert_type_CSR)"
            $temp | Add-Member -MemberType NoteProperty -Name "Type CSR existing" -Value "$($result.cert_type_existing)"
            $temp | Add-Member -MemberType NoteProperty -Name "Type Internal" -Value "$($result.cert_type_internal)"
            $temp | Add-Member -MemberType NoteProperty -Name "Valid until" -Value "$($result.cert_until)"
            $Certificate.Add($temp) | Out-Null


        }
        else
        {

            for ($i = 0; $i -lt $result.Count; $i++)
            {

                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result[$i].cert_name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "CSR" -Value "$($result[$i].cert_CSR)"
                $temp | Add-Member -MemberType NoteProperty -Name "DN" -Value "$($result[$i].cert_DN)"
                $temp | Add-Member -MemberType NoteProperty -Name "Certificate" -Value "$($result[$i].cert_certificate)"
                $temp | Add-Member -MemberType NoteProperty -Name "Chain" -Value "$($result[$i].cert_chain)"
                $temp | Add-Member -MemberType NoteProperty -Name "City" -Value "$($result[$i].cert_city)"
                $temp | Add-Member -MemberType NoteProperty -Name "Common" -Value "$($result[$i].cert_common)"
                $temp | Add-Member -MemberType NoteProperty -Name "Country" -Value "$($result[$i].cert_country)"
                $temp | Add-Member -MemberType NoteProperty -Name "Disgest Algorithm" -Value "$($result[$i].cert_digest_algorithm)"
                $temp | Add-Member -MemberType NoteProperty -Name "Email" -Value "$($result[$i].cert_email)"
                $temp | Add-Member -MemberType NoteProperty -Name "From" -Value "$($result[$i].cert_from)"
                $temp | Add-Member -MemberType NoteProperty -Name "Issuer" -Value "$($result[$i].cert_issuer)"
                $temp | Add-Member -MemberType NoteProperty -Name "Key Lenght" -Value "$($result[$i].cert_key_length)"
                $temp | Add-Member -MemberType NoteProperty -Name "Lifetime" -Value "$($result[$i].cert_lifetime)"
                $temp | Add-Member -MemberType NoteProperty -Name "Organization" -Value "$($result[$i].cert_organization)"
                $temp | Add-Member -MemberType NoteProperty -Name "PrivateKey" -Value "$($result[$i].cert_privatekey)"
                $temp | Add-Member -MemberType NoteProperty -Name "Serial" -Value "$($result[$i].cert_serial)"
                $temp | Add-Member -MemberType NoteProperty -Name "State" -Value "$($result[$i].cert_state)"
                $temp | Add-Member -MemberType NoteProperty -Name "Type" -Value "$($result[$i].cert_type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Type CSR" -Value "$($result[$i].cert_type_CSR)"
                $temp | Add-Member -MemberType NoteProperty -Name "Type CSR existing" -Value "$($result[$i].cert_type_existing)"
                $temp | Add-Member -MemberType NoteProperty -Name "Type Internal" -Value "$($result[$i].cert_type_internal)"
                $temp | Add-Member -MemberType NoteProperty -Name "Valid until" -Value "$($result[$i].cert_until)"
                $Certificate.Add($temp) | Out-Null
            }

        }
        return $Certificate



    }
    End
    {
    }
}
<#
      .SYNOPSIS
      This function return all disk present  on your FreeNas Server
      .DESCRIPTION
      This function return all disk present  on your FreeNas Server
      .EXAMPLE
        PS C:\> Get-FreeNasDisk

        Name Size_GB
        ---- -------
        ada0      20
        da0       30
        da1       30
        da2       30
        da3       30
        da4       30
        da5       30
        da6       30
        .NOTES
      This command allow to find all disk available on your FreeNas or TrueNas server

      .FUNCTIONALITY
      Use this command when you want list your disk on your FreeNas or TrueNas server
      #>

function Get-FreeNasDisk
{
    [CmdletBinding()]
    Param( )

    $Uri = "api/v1.0/storage/disk/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    foreach ($disk in $results)
    {
        $Name = ($disk.disk_name)
        $Size_GB = ([Math]::Round($disk.disk_size / 1024 / 1024 / 1024, 2))
        Write-Verbose -Message " Find the disk $name with the size $Size_GB"
        [PSCustomObject]@{
            Name    = ($disk.disk_name)
            Size_GB = ([Math]::Round($disk.disk_size / 1024 / 1024 / 1024, 2))
        }
    }
}
<#
      .SYNOPSIS
      This function return the global configuration for your FreeNas Server
      .DESCRIPTION
      This function return the global configuration for your FreeNas Server
      .EXAMPLE
        PS C:\> Get-FreeNasGlobalConfig

        Id          : 1
        Domain      : local
        Gateway     : 10.255.255.254
        Hostname    : freenas
        Nameserver1 : 1.1.1.1
        Nameserver2 : 8.8.8.8
        Nameserver3 :
        Httpproxy   :

        .NOTES
      This command return the global configuration for your FreeNas or TrueNas server

      .FUNCTIONALITY
      Use this command when you want find the actual configuration FreeNas or TrueNas server
      #>

function Get-FreeNasGlobalConfig
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/network/globalconfiguration/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $Global = new-Object -TypeName PSObject

        $Global | add-member -name "Id" -membertype NoteProperty -Value "$($result.id)"
        $Global | add-member -name "Domain" -membertype NoteProperty -Value "$($result.gc_domain)"
        $Global | add-member -name "Gateway" -membertype NoteProperty -Value "$($result.gc_ipv4gateway)"
        $Global | add-member -name "Hostname" -membertype NoteProperty -Value "$($result.gc_hostname)"
        $Global | add-member -name "Nameserver1" -membertype NoteProperty -Value "$($result.gc_nameserver1)"
        $Global | add-member -name "Nameserver2" -membertype NoteProperty -Value "$($result.gc_nameserver2)"
        $Global | add-member -name "Nameserver3" -membertype NoteProperty -Value "$($result.gc_nameserver3)"
        $Global | add-member -name "Httpproxy" -membertype NoteProperty -Value "$($result.gc_httpproxy)"
        return $Global
    }
}
<#
      .SYNOPSIS
      This function return configuration for you network interface for your FreeNas Server
      .DESCRIPTION
      This function return configuration for you network interface for your FreeNas Server
      .EXAMPLE
      Here an example with DHCP enable :

        PS C:\> Get-FreeNasInterface

        Id      :
        Status  :
        Alias   :
        Dhcp    :
        Name    :
        Ipv4    :
        Netmask :
        Ipv6    :

      .EXAMPLE
      Here an example with Static configuration :

        PS C:\> Get-FreeNasInterface

        Id      : 1
        Status  : Active
        Alias   :
        Dhcp    : False
        Name    : le0
        Ipv4    : 10.0.10.0
        Netmask : 8
        Ipv6    : False

        .NOTES
      This command return the network configuration for your FreeNas or TrueNas server

      .FUNCTIONALITY
      Use this command when you want find the network configuration FreeNas or TrueNas server
      #>
function Get-FreeNasInterface
{
    [CmdletBinding()]
    [Alias()]

    Param
    ()


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/network/interface/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $Global = new-Object -TypeName PSObject

        switch ($result.int_dhcp)
        {
            'True'
            {
                $Global | add-member -name "Id" -membertype NoteProperty -Value "$($result.id)"
                $Global | add-member -name "Status" -membertype NoteProperty -Value "$($result.int_media_status)"
                $Global | add-member -name "Alias" -membertype NoteProperty -Value "$($result.int_aliases)"
                $Global | add-member -name "Dhcp" -membertype NoteProperty -Value "$($result.int_dhcp)"
                $Global | add-member -name "Name" -membertype NoteProperty -Value "$($result.int_interface)"
                $Global | add-member -name "Ipv6" -membertype NoteProperty -Value "$($result.int_ipv6auto)"
            }
            Default
            {
                $Global | add-member -name "Id" -membertype NoteProperty -Value "$($result.id)"
                $Global | add-member -name "Status" -membertype NoteProperty -Value "$($result.int_media_status)"
                $Global | add-member -name "Alias" -membertype NoteProperty -Value "$($result.int_aliases)"
                $Global | add-member -name "Dhcp" -membertype NoteProperty -Value "$($result.int_dhcp)"
                $Global | add-member -name "Name" -membertype NoteProperty -Value "$($result.int_interface)"
                $Global | add-member -name "Ipv4" -membertype NoteProperty -Value "$($result.int_ipv4address)"
                $Global | add-member -name "Netmask" -membertype NoteProperty -Value "$($result.int_v4netmaskbit)"
                $Global | add-member -name "Ipv6" -membertype NoteProperty -Value "$($result.int_ipv6auto)"

            }
        }
        return $Global
    }
}
<#
      .SYNOPSIS
      This function return Internal CA for your FreeNas Server
      .DESCRIPTION
      This function return Internal CA for your FreeNas Server
      .EXAMPLE

      PS C:\> Get-FreeNasInternalCA

        CA_type_existing      : False
        CA_type_intermediate  : False
        CA_type_internal      : True
        cert_CSR              :
        cert_DN               : /C=US/ST=US/L=New York/O=FreeNas/CN=FreeNas/emailAddress=freenas@JM2K69.loc
        cert_certificate      : -----BEGIN CERTIFICATE-----
                                MIIDpjCCAo6gAwIBAgIEAMoKjjANBgkqhkiG9w0BAQsFADBzMQswCQYDVQQGEwJV
                                -----END CERTIFICATE-----

        cert_chain            : False
        cert_city             : New York
        cert_common           : FreeNas
        cert_country          : US
        cert_digest_algorithm : SHA256
        cert_email            : freenas@JM2K69.it
        cert_from             : Thu Oct 24 05:36:35 2019
        cert_internal         : YES
        cert_issuer           : self-signed
        cert_key_length       : 2048
        cert_lifetime         : 3650
        cert_name             : CAInternal
        cert_ncertificates    : 2
        cert_organization     : FreeNas
        cert_privatekey       : -----BEGIN PRIVATE KEY-----
                                MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQCn6q6U+PfVCqzl
                                8ZulOiwcns2zxxRK0uAU1VLsctQ=
                                -----END PRIVATE KEY-----
        cert_san              :
        cert_serial           : 13240974
        cert_state            : US
        cert_type             : 2
        cert_until            : Sun Oct 21 05:36:35 2029
        id                    : 1

        .NOTES
      This command return the certification authority your FreeNas or TrueNas server

      .FUNCTIONALITY
      Use this command when you want to enable secure connectio https with your FreeNas or TrueNas server
      #>
function Get-FreeNasInternalCA
{
  [CmdletBinding()]
  [Alias()]
  Param
  ()


  Begin
  { }
  Process
  {
    $Uri = "api/v1.0/system/certificateauthority/"

    $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get
    return $result
  }
  End
  {
  }
}
function Get-FreeNasIscsiAssociat2Extent
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [ValidateSet("Id", "Name")]
        [string]$Output = "Id"

    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/iscsi/targettoextent/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

        switch ($Output)
        {
            'Id'
            {
                $FreenasIscsiAssociat2Extent = New-Object -TypeName System.Collections.ArrayList
                for ($i = 0; $i -lt $result.Count; $i++)
                {
                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].Id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi_Extent_Id" -Value "$($result[$i].iscsi_extent)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi_LunId" -Value "$($result[$i].iscsi_lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi_Target_Id" -Value "$($result[$i].iscsi_target)"

                    $FreenasIscsiAssociat2Extent.Add($temp) | Out-Null
                }
            }
            'Name'
            {
                $FreenasIscsiAssociat2Extent = New-Object -TypeName System.Collections.ArrayList
                for ($i = 0; $i -lt $result.Count; $i++)
                {
                    $value = $result[$i].iscsi_extent
                    $value2 = $result[$i].iscsi_target
                    $TargetName = Get-FreenasIscsiTarget
                    $IscsiExtend = Get-FreenasIscsiExtent


                    foreach ($item in $TargetName)
                    {
                        if ( $Item.Id -eq $value2 )
                        {
                            $TargetNameF = $item.Target_Name
                        }

                    }

                    foreach ($item in $IscsiExtend)
                    {
                        if ( $Item.Id -eq $value )
                        {
                            $IscsiExtendF = $item.Extent_Name
                        }
                    }


                    $temp = New-Object -TypeName System.Object
                    $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].Id)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Iscsi_Extent_Name" -Value $IscsiExtendF
                    $temp | Add-Member -MemberType NoteProperty -Name "LUN Id" -Value "$($result[$i].iscsi_lunid)"
                    $temp | Add-Member -MemberType NoteProperty -Name "Target_Name" -Value $TargetNameF

                    $FreenasIscsiAssociat2Extent.Add($temp) | Out-Null
                }

            }

        }

        return $FreenasIscsiAssociat2Extent
    }
    End
    { }
}
function Get-FreeNasIscsiConf
{
    Param
    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/iscsi/globalconfiguration/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $IscsiConf = New-Object -TypeName System.Collections.ArrayList

        $temp = New-Object -TypeName PSObject
        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
        $temp | Add-Member -MemberType NoteProperty -Name "Base Name" -Value $result.iscsi_basename
        $temp | Add-Member -MemberType NoteProperty -Name "ISNS Server" -Value $result.iscsi_isns_servers
        $temp | Add-Member -MemberType NoteProperty -Name "Pool available space Threshold (%)" -Value $result.iscsi_pool_avail_threshold

        $IscsiConf.Add($temp) | Out-Null

        return $IscsiConf | fl
    }
}
function Get-FreeNasIscsiExtent
{

    Param
    ()


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/iscsi/extent/"
        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

        $Extent = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.Count)
        {
            try
            {
                if ($($result.iscsi_target_extent_type) -eq "Disk")
                {

                    $Disk_path = $($result.iscsi_target_extent_path)
                    $value = $Disk_path.Substring($Disk_path.Length - 3)

                    $DiskFreenas = Get-FreenasDisk

                    foreach ($item in $DiskFreenas)
                    {
                        if ($item.Name -eq $value)
                        {
                            $diskSize = $Item.Size_GB
                        }
                    }

                }
            }
            Catch { throw }
            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value  "$($result.id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent_Type" -Value "$($result.iscsi_target_extent_type)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent_Name" -Value  "$($result.iscsi_target_extent_name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent_Size" -Value   $diskSize
            $temp | Add-Member -MemberType NoteProperty -Name "Extent_path" -Value  "$($result.iscsi_target_extent_path)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent_Block_Size" -Value  "$($result.iscsi_target_extent_blocksize)"
            $temp | Add-Member -MemberType NoteProperty -Name "Extent_Speed_Type" -Value "$($result.iscsi_target_extent_rpm)"

            $Extent.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                try
                {
                    if ($($result[$i].iscsi_target_extent_type) -eq "Disk")
                    {

                        $Disk_path = $($result[$i].iscsi_target_extent_path)
                        $value = $Disk_path.Substring($Disk_path.Length - 3)

                        $DiskFreenas = Get-FreenasDisk

                        foreach ($item in $DiskFreenas)
                        {
                            if ($item.Name -eq $value)
                            {
                                $diskSize = $Item.Size_GB
                            }
                        }

                    }
                }
                Catch { throw }
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value  "$($result[$i].id)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent_Type" -Value "$($result[$i].iscsi_target_extent_type)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent_Name" -Value  "$($result[$i].iscsi_target_extent_name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent_Size" -Value   $diskSize
                $temp | Add-Member -MemberType NoteProperty -Name "Extent_path" -Value  "$($result[$i].iscsi_target_extent_path)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent_Block_Size" -Value  "$($result[$i].iscsi_target_extent_blocksize)"
                $temp | Add-Member -MemberType NoteProperty -Name "Extent_Speed_Type" -Value "$($result[$i].iscsi_target_extent_rpm)"
                $Extent.Add($temp) | Out-Null
            }

        }

        return $Extent


    }
    End
    { }
}
function Get-FreeNasIscsiInitiator
{
    Param
    ( )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/iscsi/authorizedinitiator/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

        $Obj = New-Object -TypeName System.Collections.ArrayList

        $temp = New-Object -TypeName System.Object
        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
        $temp | Add-Member -MemberType NoteProperty -Name "Initiator" -Value $result.iscsi_target_initiator_initiators
        $temp | Add-Member -MemberType NoteProperty -Name "Auth Network" -Value $result.iscsi_target_initiator_auth_network
        $temp | Add-Member -MemberType NoteProperty -Name "Comments" -Value $result.iscsi_target_initiator_comment

        $Obj.Add($temp) | Out-Null



        return $Obj


    }
    End
    { }
}
function Get-FreeNasIscsiPortal
{
    Param
    ( )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/iscsi/portal/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

        $Obj = New-Object -TypeName System.Collections.ArrayList
        $temp = New-Object -TypeName System.Object
        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
        if ($null -eq $result.iscsi_target_portal_ips)
        {

        }
        else
        {
            $temp | Add-Member -MemberType NoteProperty -Name "Portal IPs" -Value $($result.iscsi_target_portal_ips).Split(":")[0]
            $temp | Add-Member -MemberType NoteProperty -Name "Portal ports" -Value $($result.iscsi_target_portal_ips).Split(":")[1]
            $temp | Add-Member -MemberType NoteProperty -Name "Portal Discovery Method" -Value $result.iscsi_target_portal_discoveryauthmethod

            $Obj.Add($temp) | Out-Null
        }

        return $Obj


    }
    End
    { }
}
function Get-FreeNasIscsiSummary
{
    [Alias()]
    Param
    ()

    Begin
    {

    }
    Process
    {
        $Extent_Iscsi = Get-FreenasIscsiExtent
        $Association = Get-FreenasIscsiAssociat2Extent -Output Name
        $Target_Iscsi = Get-FreenasIscsiTarget

        New-banner -Text "____________" -Online -FontColor Green
        New-banner -Text "Iscsi Summary" -Online

        Write-Host "Your Freenas Server" -NoNewline
        Write-Host " $script:SrvFreenas" -NoNewline -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Iscsi Configuration : " -ForegroundColor Yellow
        Get-FreenasIscsiConf

        Write-host "The Iscsi Portal : " -ForegroundColor Yellow
        Get-FreenasIscsiPortal
        Write-host "The Target Iscsi :" -ForegroundColor Yellow
        write-host ""
        get-FreenasIscsiInitiator
        Write-host "The Iscsi Extent : " -ForegroundColor Yellow

        $TotalSize = ""
        for ($i = 0; $i -lt $Extent_Iscsi.Count; $i++)
        {
            [int]$Size = [Math]::Round($Extent_Iscsi[$i].Extent_Size , 2)
            [Int]$TotalSize = $TotalSize + $Size
        }
        Write-host "The Server have"$($Extent_Iscsi).count"Extent(s) with a total size" -NoNewline
        Write-Host " $TotalSize " -NoNewline -ForegroundColor Green
        Write-Host "GB"
        Write-host "The Iscsi Extent Type : " -ForegroundColor Yellow
        Get-FreenasIscsiExtent | FT
        Write-host "The Target Iscsi :" -ForegroundColor Yellow
        $Target_Iscsi | ft
        Write-host "The Association Target with Extend :" -ForegroundColor Yellow

        $Association | ft
    }
    End
    {
        New-banner -Text "End Summary"  -Online -FontColor Red

    }
}
function Get-FreeNasIscsiTarget
{
    Param
    ( )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/iscsi/target/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

        $FreenasIscsiTarget = New-Object -TypeName System.Collections.ArrayList
        for ($i = 0; $i -lt $result.Count; $i++)
        {
            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].Id)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target_Alias" -Value "$($result[$i].iscsi_target_alias)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target_Name" -Value "$($result[$i].iscsi_target_name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Target_Mode" -Value "$($result[$i].iscsi_target_mode)"

            $FreenasIscsiTarget.Add($temp) | Out-Null
        }


        return $FreenasIscsiTarget
    }
    End
    { }
}
function Get-FreeNasIscsiTargetGroup {
    Param( )

    $Uri = "api/v1.0/services/iscsi/targetgroup/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    foreach ($Target in $results) {
        [PSCustomObject]@{
            Id                     = ($Target.iscsi_target)
            Target_Auth_Group      = ($Target.iscsi_target_authgroup)
            Target_Portal_Group    = ($Target.iscsi_target_portalgroup)
            Target_Initiator_Group = ($Target.iscsi_target_initiatorgroup)
            Target_Auth_Type       = ($Target.iscsi_target_authtype)
            Target_Intial_Disgest  = ($Target.iscsi_target_initialdigest)

        }
    }
}
function Get-FreeNasServer {
    Param
    ( )
    return  $script:SrvFreenas
}
function Get-FreeNasService
{
    Param
    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/services/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $result
    }
}
function Get-FreeNasSetting
{
    [CmdletBinding()]
    [Alias()]
    Param
    ()


    Begin
    { }
    Process
    {
        $Uri = "api/v1.0/system/settings/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get
    }
    End
    {
        $Global = new-Object -TypeName PSObject

        $Global | add-member -name "Id" -membertype NoteProperty -Value "$($result.id)"
        $Global | add-member -name "GUI address" -membertype NoteProperty -Value "$($result.stg_guiaddress)"
        $Global | add-member -name "GUI certificate" -membertype NoteProperty -Value "$($result.stg_guicertificate)"
        $Global | add-member -name "GUI https port" -membertype NoteProperty -Value "$($result.stg_guihttpsport)"
        $Global | add-member -name "GUI https redirect" -membertype NoteProperty -Value "$($result.stg_guihttpsredirect)"
        $Global | add-member -name "GUI port" -membertype NoteProperty -Value "$($result.stg_guiport)"
        $Global | add-member -name "GUI protocol" -membertype NoteProperty -Value "$($result.stg_guiprotocol)"
        $Global | add-member -name "Language" -membertype NoteProperty -Value "$($result.stg_language)"
        $Global | add-member -name "SysLog level" -membertype NoteProperty -Value "$($result.stg_sysloglevel)"
        $Global | add-member -name "SysLog server" -membertype NoteProperty -Value "$($result.stg_syslogserver)"
        $Global | add-member -name "Timezone" -membertype NoteProperty -Value "$($result.stg_timezone)"
        $Global | add-member -name "Wizard shown" -membertype NoteProperty -Value "$($result.stg_wizardshown)"
        return $Global
    }
}
<#
.SYNOPSIS
    This function return Advanced Informations about your FreeNas Server
.DESCRIPTION
    This function return Advanced Informations about your FreeNas Server
.EXAMPLE
    PS C:\> Get-FreeNasSystemAdvanced
#>
function Get-FreeNasSystemAdvanced
{
    Param( )

    $Uri = "api/v1.0/system/advanced/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    foreach ($Info in $results)
    {
        [PSCustomObject]@{
            Advanced_mode           = ($Info.adv_advancedmode)
            Advanced_Autotune       = ($Info.adv_autotune)
            MOTD_Banner             = ($Info.adv_motd)
            Advanced_Sawp_on_disk   = ($Info.adv_swapondrive)
            Advanced_Serial_Console = ($Info.adv_serialconsole)
            Advanced_Serial_port    = ($Info.adv_serialport)
            Advanced_Serial_speed   = ($Info.adv_serialspeed)

        } | fl
    }
}
<#
.SYNOPSIS
    This function return All Alerts for your FreeNas Server
.DESCRIPTION
    This function return All Alerts for your FreeNas Server
.EXAMPLE
    PS C:\> Get-FreeNasSystemAlert
Id        : 256ad2f48e5e541e28388701e34409cc
Level     : OK
Message   : The volume tank (ZFS) status is HEALTHY
Dismissed : false
#>
function Get-FreeNasSystemAlert {
    Param( )

    $Uri = "api/v1.0/system/alert/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    foreach ($Alert in $results) {
        [PSCustomObject]@{
            Id        = ($Alert.id)
            Level     = ($Alert.level)
            Message   = ($Alert.message)
            Dismissed = ($Alert.dismissed)
        } | fl
    }
}
function Get-FreeNasSystemEmail
{
    [Alias()]
    Param
    ()

    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/system/email/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

        $FreeNasConf = New-Object -TypeName System.Collections.ArrayList

        $temp = New-Object -TypeName PSObject
        $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value $result.id
        $temp | Add-Member -MemberType NoteProperty -Name "From_Email" -Value $result.em_fromemail
        $temp | Add-Member -MemberType NoteProperty -Name "Outgoing_Mail_Server" -Value $result.em_outgoingserver
        $temp | Add-Member -MemberType NoteProperty -Name "Port" -Value $result.em_port
        $temp | Add-Member -MemberType NoteProperty -Name "SMTP" -Value $result.smtp
        $temp | Add-Member -MemberType NoteProperty -Name "User" -Value $result.em_user
        $temp | Add-Member -MemberType NoteProperty -Name "Security" -Value $result.em_security


        $FreeNasConf.Add($temp) | Out-Null


        return $FreeNasConf | fl


    }
    End { }
}
function Get-FreeNasSystemNTP
{
    [Alias()]
    Param
    ()

    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/system/ntpserver/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

        $FreenasConf = New-Object -TypeName System.Collections.ArrayList
        for ($i = 0; $i -lt $result.Count; $i++)
        {

            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].id)"
            $temp | Add-Member -MemberType NoteProperty -Name "NTP_Server" -Value "$($result[$i].ntp_address)"
            $temp | Add-Member -MemberType NoteProperty -Name "NTP_Burst" -Value "$($result[$i].ntp_burst)"
            $temp | Add-Member -MemberType NoteProperty -Name "NTP_iBurst" -Value "$($result[$i].ntp_iburst)"
            $temp | Add-Member -MemberType NoteProperty -Name "NTP_Max_Poll" -Value "$($result[$i].ntp_maxpoll)"
            $temp | Add-Member -MemberType NoteProperty -Name "NTP_Prefrer" -Value "$($result[$i].ntp_prefer)"
            $FreenasConf.Add($temp) | Out-Null
        }

        return $FreenasConf | FT

    }
    End { }
}
<#
.SYNOPSIS
    This Function permit ta find Update for your FreeNas Server
.DESCRIPTION
This Function permit ta find Update for your FreeNas Server
.EXAMPLE
    PS C:\> Get-FreeNasSystemUpdate
    This function return all updates if they are available for your system
.NOTES
#>
function Get-FreeNasSystemUpdate {
    Param( )

    $Uri = "api/v1.0/system/update/check/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    return $results
}
<#
.SYNOPSIS
This function return informations about your FreeNas server.
.DESCRIPTION
This function return informations about your FreeNas server.
.EXAMPLE
    PS C:\> Get-FreeNasSystemVersion

    Name         : FreeNAS
    Full_version : FreeNAS-11.2-U2.1 (675d9aba9)
    Version      :
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Get-FreeNasSystemVersion {
    Param( )

    $Uri = "api/v1.0/system/version/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    foreach ($Info in $results) {
        [PSCustomObject]@{
            Name         = ($Info.name)
            Full_version = ($Info.fullversion)
            Version      = ($Info.version)
        }
    }
}
function Get-FreeNasVolume
{
    Param

    ( )

    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/storage/volume/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $FreenasVolume = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.count)
        {
            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.Name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result.Id)"
            $temp | Add-Member -MemberType NoteProperty -Name "MountPoint" -Value "$($result.mountpoint)"
            $temp | Add-Member -MemberType NoteProperty -Name "Status" -Value "$($result.status)"
            $temp | Add-Member -MemberType NoteProperty -Name "Space_Used_GB" -Value "$([Math]::Round($result.used/1024/1024/1024,4))"
            $temp | Add-Member -MemberType NoteProperty -Name "Space_Available_GB" -Value "$([Math]::Round($result.avail/1024/1024/1024,2)) "

            $FreenasVolume.Add($temp) | Out-Null

        }
        else
        {
            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result[$i].Name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Id" -Value "$($result[$i].Id)"
                $temp | Add-Member -MemberType NoteProperty -Name "MountPoint" -Value "$($result[$i].mountpoint)"
                $temp | Add-Member -MemberType NoteProperty -Name "Status" -Value "$($result[$i].status)"
                $temp | Add-Member -MemberType NoteProperty -Name "Space_Used_GB" -Value "$([Math]::Round($result[$i].used/1024/1024/1024,4))"
                $temp | Add-Member -MemberType NoteProperty -Name "Space_Available_GB" -Value "$([Math]::Round($result[$i].avail/1024/1024/1024,2)) "

                $FreenasVolume.Add($temp) | Out-Null
            }

        }


        return $FreenasVolume



    }
}
function Get-FreeNasZvol
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter (Mandatory = $true)]
        [string]$VolumeName

    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/storage/volume/$VolumeName/zvols/"

        $result = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    }
    End
    {
        $ZVolume = New-Object -TypeName System.Collections.ArrayList

        if ($null -eq $result.count)
        {
            $temp = New-Object -TypeName System.Object
            $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result.Name)"
            $temp | Add-Member -MemberType NoteProperty -Name "Comments" -Value "$($result.comments)"
            $temp | Add-Member -MemberType NoteProperty -Name "Deduplication" -Value "$($result.dedup)"
            $temp | Add-Member -MemberType NoteProperty -Name "Compression" -Value "$($result.compression)"
            $temp | Add-Member -MemberType NoteProperty -Name "Space Used in GB" -Value "$([Math]::Round($result.used /1024/1024/1024,4))"
            $temp | Add-Member -MemberType NoteProperty -Name "Volume Size in GB" -Value "$([Math]::Round($result.volsize /1024/1024/1024,2)) "

            $ZVolume.Add($temp) | Out-Null


        }
        else
        {

            for ($i = 0; $i -lt $result.Count; $i++)
            {
                $temp = New-Object -TypeName System.Object
                $temp | Add-Member -MemberType NoteProperty -Name "Name" -Value "$($result[$i].Name)"
                $temp | Add-Member -MemberType NoteProperty -Name "Comments" -Value "$($result[$i].comments)"
                $temp | Add-Member -MemberType NoteProperty -Name "Deduplication" -Value "$($result[$i].dedup)"
                $temp | Add-Member -MemberType NoteProperty -Name "Compression" -Value "$($result[$i].compression)"
                $temp | Add-Member -MemberType NoteProperty -Name "Space Used in GB" -Value "$([Math]::Round($result[$i].used /1024/1024/1024,4))"
                $temp | Add-Member -MemberType NoteProperty -Name "Volume Size in GB" -Value "$([Math]::Round($result[$i].volsize /1024/1024/1024,2)) "
                $ZVolume.Add($temp) | Out-Null
            }

        }
        return $ZVolume



    }
}
<#
.Synopsis
   This Function find the major version of Powershell
.EXAMPLE
   Get-PowerShellVersion
.EXAMPLE
   Get-PowerShellVersion -verbose
#>
function Get-PowerShellVersion {
   [CmdletBinding()]
   Param
   ()

   $Script:Version = $PSVersionTable.PSVersion.Major
   Write-Verbose -Message "The module is running in Powershell $Version "

}

function Invoke-FreeNasRestMethod
{

    <#
      .SYNOPSIS
      Invoke RestMethod with FreeNas connection (internal) variable

      .DESCRIPTION
      Invoke RestMethod with FreeNas connection variable (token,.)

      .EXAMPLE
      Invoke-FreeNasRestMethod -method "get" -uri "api/v1.0/storage/disk/"

      Invoke-RestMethod with FreeNas connection for get api/v1.0/storage/disk/ uri
    #>

    Param(
        [Parameter(Mandatory = $true, position = 1)]
        [String]$uri,
        [Parameter(Mandatory = $false)]
        [ValidateSet("GET", "PUT", "POST", "DELETE")]
        [String]$method = "GET",
        [Parameter(Mandatory = $false)]
        [psobject]$body
    )

    Begin
    {

    }

    Process
    {

        if ($null -eq $Script:SrvFreenas)
        {
            Throw "Not Connected. Connect to the FreeNas with Connect-FreeNasServer"
        }

        $Server = $Script:SrvFreenas
        $sessionvariable = $Script:Session
        $headers = $Script:Headers
        $invokeParams = $Script:invokeParams
        $httpOnly = $Script:httpOnly
        $port = $Script:port

        if ($httpOnly) {
            $fullurl = "http://${Server}:${port}/${uri}"
        }
        else {
            $fullurl = "https://${Server}:${port}/${uri}"
        }

        try
        {
            if ($body)
            {
                $response = Invoke-RestMethod $fullurl -Method $method -body ($body | ConvertTo-Json -Compress -Depth 3) -WebSession $sessionvariable -headers $headers @invokeParams
            }
            else
            {
                $response = Invoke-RestMethod $fullurl -Method $method -WebSession $sessionvariable -headers $headers @invokeParams
            }
        }

        catch
        {
            Show-FreeNasException $_
            throw "Unable to use FreeNAS API"
        }
        $response

    }

}
function New-FreeNasCertificate
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$Name,

        [Parameter (Mandatory = $true)]
        [String]$CommonName,

        [Parameter (Mandatory = $True)]
        [String]$City,

        [Parameter (Mandatory = $true)]
        [String]$State,

        [Parameter (Mandatory = $True)]
        [String]$Country,

        [Parameter (Mandatory = $True)]
        [String]$Email,

        [Parameter (Mandatory = $True)]
        [String]$Organization,

        [Parameter (Mandatory = $True)]
        [ValidateSet("SHA1", "SHA224", "SHA256", "SHA384", "SHA512")]
        [String]$DigestAlgo,

        [Parameter (Mandatory = $True)]
        [Int]$Liftime ,

        [Parameter (Mandatory = $True)]
        [ValidateSet("1024", "2048", "4096")]
        [Int]$KeyLenght,

        [Parameter (Mandatory = $true)]
        [Int]$Signedby

    )


    Begin
    { }

    Process
    {
        $Uri = "api/v1.0/system/certificate/internal/"
        $Obj = new-Object -TypeName PSObject

        $Obj | add-member -name "cert_city" -membertype NoteProperty -Value $City
        $Obj | add-member -name "cert_email" -membertype NoteProperty -Value $Email
        $Obj | add-member -name "cert_common" -membertype NoteProperty -Value $CommonName
        $Obj | add-member -name "cert_country" -membertype NoteProperty -Value $Country
        $Obj | add-member -name "cert_digest_algorithm" -membertype NoteProperty -Value $DigestAlgo
        $Obj | add-member -name "cert_lifetime" -membertype NoteProperty -Value $Liftime
        $Obj | add-member -name "cert_name" -membertype NoteProperty -Value $Name
        $Obj | add-member -name "cert_organization" -membertype NoteProperty -Value $Organization
        $Obj | add-member -name "cert_state" -membertype NoteProperty -Value $State
        $Obj | add-member -name "cert_key_length" -membertype NoteProperty -Value $KeyLenght
        $Obj | add-member -name "cert_signedby" -membertype NoteProperty -Value $Signedby

        if ($PSCmdlet.ShouldProcess( "We are update FreeNas system "))
        {
            $response = Invoke-FreeNasRestMethod -Method Post -body $Obj -Uri $uri

        }
    }

    End
    { }
}
function New-FreeNasInternalCA
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$Name,

        [Parameter (Mandatory = $true)]
        [String]$CommonName,

        [Parameter (Mandatory = $True)]
        [String]$City,


        [Parameter (Mandatory = $true)]
        [String]$State,

        [Parameter (Mandatory = $True)]
        [String]$Country,

        [Parameter (Mandatory = $True)]
        [String]$Email,

        [Parameter (Mandatory = $True)]
        [String]$Organization ,

        [Parameter (Mandatory = $True)]
        [ValidateSet("SHA1", "SHA224", "SHA256", "SHA384", "SHA512")]
        [String]$DigestAlgo ,

        [Parameter (Mandatory = $True)]
        [Int]$Liftime ,

        [Parameter (Mandatory = $True)]
        [ValidateSet("1024", "2048", "4096")]
        [Int]$KeyLenght
    )


    Begin
    { }

    Process
    {

        $Uri = "api/v1.0/system/certificateauthority/internal/"

        $Obj = new-Object -TypeName PSObject


        $Obj | add-member -name "cert_city" -membertype NoteProperty -Value $City
        $Obj | add-member -name "cert_email" -membertype NoteProperty -Value $Email
        $Obj | add-member -name "cert_common" -membertype NoteProperty -Value $CommonName
        $Obj | add-member -name "cert_country" -membertype NoteProperty -Value $Country
        $Obj | add-member -name "cert_digest_algorithm" -membertype NoteProperty -Value $DigestAlgo
        $Obj | add-member -name "cert_lifetime" -membertype NoteProperty -Value $Liftime
        $Obj | add-member -name "cert_name" -membertype NoteProperty -Value $Name
        $Obj | add-member -name "cert_organization" -membertype NoteProperty -Value $Organization
        $Obj | add-member -name "cert_state" -membertype NoteProperty -Value $State
        $Obj | add-member -name "cert_key_length" -membertype NoteProperty -Value $KeyLenght

        if ($PSCmdlet.ShouldProcess( "We are update FreeNas system "))
        {
            $response = Invoke-FreeNasRestMethod -Method Post -body $Obj -Uri $uri
        }
    }
    End
    { }
}
function New-FreeNasIscsiAssociat2Extent
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [INT]$TargetId,

        [Parameter (Mandatory = $true)]
        [INT]$ExtentId

    )


    Begin
    {

    }

    Process
    {
        $Uri = "api/v1.0/services/iscsi/targettoextent/"

        $Obj = [Ordered]@{
            iscsi_target = $TargetId
            iscsi_extent = $ExtentId
            iscsi_lunid  = 0

        }

        $result = Invoke-FreeNasRestMethod -method Post -body $Obj -Uri $Uri

    }

    End
    { }
}
function New-FreeNasIscsiExtent {

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$ExtentName,

        [Parameter (Mandatory = $true)]
        [ValidateSet("Disk", "File")]
        [String]$ExtenType,

        [Parameter (Mandatory = $true)]
        [ValidateSet("Unknown", "SSD", "5400", "7200", "10000", "15000")]
        $ExtentSpeed,


        [Parameter (Mandatory = $true)]
        [String]$ExtenDiskPath


    )


    Begin {

    }

    Process {
        $Uri = "api/v1.0/services/iscsi/extent/"

        $Obj = [Ordered]@{
            iscsi_target_extent_type = $ExtenType
            iscsi_target_extent_name = $ExtentName
            iscsi_target_extent_disk = $ExtenDiskPath
            iscsi_target_extent_rpm  = $ExtentSpeed

        }

        Invoke-FreeNasRestMethod -method Post -body $Obj -Uri $Uri

    }

    End
    { }
}
function New-FreeNasIscsiInitiator {
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $False)]
        [ValidateSet("ALL")]
        [string]$AuthInitiators,

        [Parameter (Mandatory = $False)]
        [ValidateSet("ALL")]
        [String]$AuthNetwork

    )


    Begin {

    }
    Process {
        $Uri = "api/v1.0/services/iscsi/authorizedinitiator/"

        $Obj = [Ordered]@{
            iscsi_target_initiator_initiators   = $AuthInitiators
            iscsi_target_initiator_auth_network = $AuthNetwork
        }

        $response = Invoke-FreeNasRestMethod -method Post -body $Obj -Uri $Uri

    }
    End
    {

    }
}
function New-FreenasIscsiPortal {
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter (Mandatory = $true)]
        $IpPortal,

        [Parameter (Mandatory = $false)]
        [string]$Port = 3260 ,


        [Parameter (Mandatory = $false)]
        [string]$Comment



    )


    Begin {

    }
    Process {
        $Uri = "api/v1.0/services/iscsi/portal/"

        $input = @($IpPortal + ":" + $Port)

        $IpPortalPort = @()

        foreach ($item in $input) {
            $IpPortalPort += $item
        }

        $Obj = [Ordered]@{
            iscsi_target_portal_ips     = $IpPortalPort
            iscsi_target_portal_comment = $Comment
        }

        $response = Invoke-FreeNasRestMethod -method Post -body $Obj -Uri $Uri

    }
    End
    {

    }
}
function New-FreeNasIscsiTarget {
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter (Mandatory = $true)]
        [string]$TargetName,

        [Parameter (Mandatory = $false)]
        [string]$TargetAlias,


        [Parameter (Mandatory = $false)]
        [string]$TargetMode = "iscsi"


    )


    Begin {

    }
    Process {
        $Uri = "api/v1.0/services/iscsi/target/"

        $Obj = new-Object -TypeName PSObject

        if ( $PsBoundParameters.ContainsKey('TargetName') ) {
            $Obj | add-member -name "iscsi_target_name" -membertype NoteProperty -Value $TargetName.ToLower()
        }

        if ( $PsBoundParameters.ContainsKey('TargetAlias') ) {
            $Obj | add-member -name "iscsi_target_alias" -membertype NoteProperty -Value $TargetAlias.ToLower()
        }

        $Obj | add-member -name "iscsi_target_mode" -membertype NoteProperty -Value $TargetMode.ToLower()

        $response = Invoke-FreeNasRestMethod -method Post -body $Obj -Uri $Uri

    }
    End
    {

    }
}
function New-FreeNasIscsiTargetGroup {
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $True)]
        [Int]$TargetId,

        [Parameter (Mandatory = $True)]
        [Int]$TargetPortalGroup

    )


    Begin {

    }
    Process {
        $Uri = "api/v1.0/services/iscsi/targetgroup/"

        $Obj = [Ordered]@{
            iscsi_target                = $TargetId
            iscsi_target_authgroup      = $null
            iscsi_target_authtype       = "None"
            iscsi_target_portalgroup    = $TargetPortalGroup
            iscsi_target_initiatorgroup = "1"
            iscsi_target_initialdigest  = "Auto"
        }

        $response = Invoke-FreeNasRestMethod -method Post -body $Obj -Uri $Uri

    }
    End
    {

    }
}
function New-FreeNasSystemNTP {
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter (Mandatory = $true)]
        [string]$NtpServer,

        [Parameter (Mandatory = $False)]
        [ValidateSet("True", "False")]
        [string]$PreferServer,

        [Parameter (Mandatory = $False)]
        [int]$MinPoll = 6,

        [Parameter (Mandatory = $False)]
        [int]$MaxPoll = 10,

        [Parameter (Mandatory = $False)]
        [ValidateSet("True", "False")]
        [string]$NtpBurst = "Fasle",

        [Parameter (Mandatory = $False)]
        [ValidateSet("True", "False")]
        [string]$NtpIBurst = "True"

    )


    Begin {

    }
    Process {
        $Uri = "api/v1.0/system/ntpserver/"

        $Obj = new-Object -TypeName PSObject
        $Obj | add-member -name "ntp_address" -membertype NoteProperty -Value $NtpServer
        $Obj | add-member -name "ntp_prefer" -membertype NoteProperty -Value $PreferServer
        $Obj | add-member -name "ntp_minpoll" -membertype NoteProperty -Value $MinPoll
        $Obj | add-member -name "ntp_maxpoll" -membertype NoteProperty -Value $MaxPoll
        $Obj | add-member -name "ntp_burst" -membertype NoteProperty -Value $NtpBurst
        $Obj | add-member -name "ntp_iburst" -membertype NoteProperty -Value $NtpIBurst

        $response = Invoke-FreeNasRestMethod -method Post -body $Obj -Uri $Uri

    }
    End
    { }
}
function New-FreeNasVolume
{

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$VolumeName,

        [Parameter (Mandatory = $true)]
        [ValidateSet("stripe", "mirror", "raidz", "raidz2", "raidz3")]
        [String]$Vdevtype,

        [Parameter (Mandatory = $False)]
        [String]$DiskNamebase = "da",


        [Parameter (Mandatory = $true)]
        [Int]$NbDisks,

        [Parameter (Mandatory = $false)]
        [Int]$StartDisksNB = 1


    )


    Begin
    {

    }

    Process
    {

        $FreenasVolume = @()

        $StartDisksNB..$($StartDisksNB + $NbDisks - 1) | Foreach-Object { $freenasvolume += "$DiskNamebase$_" }

        $Uri = "api/v1.0/storage/volume/"

        $Obj = [Ordered]@{
            volume_name = $VolumeName
            layout      = @(@{
                    vdevtype = $Vdevtype
                    disks    = $FreenasVolume
                })

        }

        $response = Invoke-FreeNasRestMethod -Method Post -body $Obj -Uri $uri

    }

    End
    { }
}
function New-FreeNasZvol {

    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (

        [Parameter (Mandatory = $true)]
        [string]$VolumeName,

        [Parameter (Mandatory = $true)]
        [string]$ZvolName,

        [Parameter (Mandatory = $true)]
        [Int]$Volsize,

        [Parameter (Mandatory = $False)]
        [ValidateSet("KiB", "MiB", "GiB")]
        [String]$Unit = "GiB",


        [Parameter (Mandatory = $False)]
        [ValidateSet("lz4", "gzip", "gzip-1" , "gzip-9", "zle", "lzjb")]
        [String]$Compression = "lz4",

        [Parameter (Mandatory = $False)]
        [ValidateSet("True", "False")]
        [String]$Sparse,

        [Parameter (Mandatory = $False)]
        [ValidateSet("4K", "8K", "16K" , "32K", "64K", "128K")]
        [String]$BlokSize = "4K",

        [Parameter (Mandatory = $False)]
        [String]$Comment




    )


    Begin {

    }

    Process {

        $Uri = "api/v1.0/storage/volume/$VolumeName/zvols/"


        $Zvolc = new-Object -TypeName PSObject


        if ( $PsBoundParameters.ContainsKey('ZvolName') ) {
            $Zvolc | add-member -name "name" -membertype NoteProperty -Value $ZvolName
        }

        if ( $PsBoundParameters.ContainsKey('Volsize') -and $PsBoundParameters.ContainsKey('Unit') ) {
            [String]$Size = "$volsize" + "$Unit"
            $Zvolc | add-member -name "volsize" -membertype NoteProperty -Value $Size
        }
        if ( $PsBoundParameters.ContainsKey('Sparse') ) {
            $Zvolc | add-member -name "sparse" -membertype NoteProperty -Value $Sparse
        }
        if ( $PsBoundParameters.ContainsKey('Force') ) {
            $Zvolc | add-member -name "force" -membertype NoteProperty -Value $Force
        }

        if ( $PsBoundParameters.ContainsKey('Compression') ) {
            $Zvolc | add-member -name "compression" -membertype NoteProperty -Value $Compression
        }

        if ( $PsBoundParameters.ContainsKey('Comment') ) {
            $Zvolc | add-member -name "comments" -membertype NoteProperty -Value $Comment
        }

        if ( $PsBoundParameters.ContainsKey('BlokSize') ) {
            $Zvolc | add-member -name "blocksize" -membertype NoteProperty -Value $BlokSize
        }

        $response = Invoke-FreeNasRestMethod -method Post -body $Zvolc -Uri $Uri

    }

    End {
    }
}
function Remove-FreeNasIscsiAssociat2Extent
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {

        $Uri = "api/v1.0/services/iscsi/extent/$Id/"

        if ($PSCmdlet.ShouldProcess("will be remove" , "The Association to Exent with the id $Id"))
        {
            $response = Invoke-FreeNasRestMethod -method Delete -body $post -Uri $Uri
        }

    }
    End
    {

    }
}
function Remove-FreeNasIscsiExtent
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {

        $Uri = "api/v1.0/services/iscsi/extent/$Id/"

        if ($PSCmdlet.ShouldProcess("will be remove" , "The Extent with the id $Id"))
        {
            $response = Invoke-FreeNasRestMethod -method Delete -body $post -Uri $Uri
        }

    }
    End
    {

    }
}
function Remove-FreeNasIscsiInitiator
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {

        $Uri = "api/v1.0/services/iscsi/authorizedinitiator/$Id/"

        if ($PSCmdlet.ShouldProcess("will be remove" , "The Authorized Initiator with the id $Id"))
        {
            $response = Invoke-FreeNasRestMethod -method Delete -body $post -Uri $Uri
        }

    }
    End
    {

    }
}
function Remove-FreeNasIscsiPortal
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/iscsi/portal/$Id/"

        if ($PSCmdlet.ShouldProcess("will be remove" , "The Portal with the id $Id"))
        {
            $response = Invoke-FreeNasRestMethod -method Delete -body $post -Uri $Uri
        }
    }
    End
    {

    }
}
function Remove-FreeNasIscsiTarget
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {

        $Uri = "api/v1.0/services/iscsi/target/$Id/"

        if ($PSCmdlet.ShouldProcess("will be remove" , "The Target with the id $Id"))
        {
            $response = Invoke-FreeNasRestMethod -method Delete -body $post -Uri $Uri
        }

    }
    End
    {

    }
}
function Remove-FreeNasIscsiTargetGroup
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {

        $Uri = "api/v1.0/services/iscsi/targetgroup/$Id/"

        if ($PSCmdlet.ShouldProcess("will be remove" , "The TargetGroup with the id $Id"))
        {
            $response = Invoke-FreeNasRestMethod -method Delete -body $post -Uri $Uri
        }

    }
    End
    {

    }
}
function Remove-FreeNasVolume
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {

        $Uri = "api/v1.0/storage/volume/$Id/"

        if ($PSCmdlet.ShouldProcess("will be remove" , "The volume with the id $Id"))
        {
            $response = Invoke-FreeNasRestMethod -method Delete -body $post -Uri $Uri
        }

    }
    End
    {

    }
}
function Remove-FreeNasZvol
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id
    )


    Begin
    {

    }
    Process
    {

        $Uri = "api/v1.0/storage/volume/$Id/"

        if ($PSCmdlet.ShouldProcess("will be remove" , "The volume with the id $Id"))
        {
            $response = Invoke-FreeNasRestMethod -method Delete -body $post -Uri $Uri
        }

    }
    End
    {

    }
}
<#
.SYNOPSIS
Reset to the default factory your FreeNas server
.DESCRIPTION
Reset to the default factory your FreeNas server a reboot is necessary
.EXAMPLE
    PS C:\> Reset-FreeNasSystemFactory | Stop-FreeNasSystem
#>
function Reset-FreeNasSystemFactory {
    Param( )

    $Uri = "api/v1.0/system/config/factory_restore/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Post

    $results
}
function Restart-FreeNasServer {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [Alias()]
    Param
    (
    )


    Begin {

    }
    Process {
        $Uri = "api/v1.0/system/reboot/"

        $post = Invoke-FreeNasRestMethod -method Post -body $post -Uri $Uri

    }
    End
    { }
}
function Set-FreeNasDedupZvol
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter (Mandatory = $true)]
        [string]$VolumeName,

        [Parameter (Mandatory = $true)]
        [string]$ZvolName


    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/storage/volume/$VolumeName/zvols/$ZvolName/"

        $Dedup = new-Object -TypeName PSObject

        $Dedup | add-member -name "dedup" -membertype NoteProperty -Value "on"
        $Dedup | add-member -name "force" -membertype NoteProperty -Value "true"

        $response = Invoke-FreeNasRestMethod -method Put -body $Dedup -Uri $Uri

    }
    End
    {

    }
}
function Set-FreeNasIscsiConf
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter (Mandatory = $false)]
        [string]$BaseName,

        [Parameter (Mandatory = $false)]
        [string]$isns_servers,

        [Parameter (Mandatory = $false)]
        [ValidateSet("50", "55", "60", "65", "70", "75", "80", "85", "90", "95")]
        [INT]$pool_avail_threshold


    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/iscsi/globalconfiguration/"

        $IscsiConf = new-Object -TypeName PSObject

        if ( $PsBoundParameters.ContainsKey('BaseName') )
        {
            $IscsiConf | add-member -name "iscsi_basename" -membertype NoteProperty -Value $BaseName
        }

        if ( $PsBoundParameters.ContainsKey('isns_servers') )
        {
            $IscsiConf | add-member -name "iscsi_isns_servers" -membertype NoteProperty -Value $isns_servers
        }

        if ( $PsBoundParameters.ContainsKey('pool_avail_threshold') )
        {

            $IscsiConf | add-member -name "iscsi_pool_avail_threshold" -membertype NoteProperty -Value $pool_avail_threshold
        }

        $response = Invoke-FreeNasRestMethod -method Put -body $IscsiConf -Uri $Uri

    }
    End
    {

    }
}
function Set-FreeNasIscsiPortal
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id,

        [Parameter (Mandatory = $true)]
        $IpPortal,

        [Parameter (Mandatory = $false)]
        [string]$Port = 3260 ,


        [Parameter (Mandatory = $true)]
        [ValidateSet("None", "Auto", "CHAP", "CHAP Mutual")]
        [String]$DiscoveryAuthMethod

    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/iscsi/portal/$Id/"
        $input = @($IpPortal + ":" + $Port)

        $IpPortalPort = @()
        $IpPortalPort += $input

        $Obj = [Ordered]@{
            iscsi_target_portal_ips                 = $IpPortalPort
            iscsi_target_portal_discoveryauthmethod = $DiscoveryAuthMethod
        }

        $response = Invoke-FreeNasRestMethod -method Put -body $Obj -Uri $Uri

    }
    End
    {

    }
}
function Set-FreeNasService
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [Alias()]
    [OutputType([int])]
    Param
    (
        [Parameter (Mandatory = $true)]
        [ValidateSet("afp", "cifs", "dynamicdns" , "ftp", "iscsitarget", "nfs", "snmp", "ssh", "tftp", "ups", "rsync", "smartd", "domaincontroller", "lldp", "webdav", "s3", "netdata")]
        [string]$Services,

        [Parameter (Mandatory = $true)]
        [ValidateSet("True", "False")]
        [string]$ServicesStatus


    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/services/services/$Services/"

        $Status = new-Object -TypeName PSObject

        $Status | add-member -name "srv_enable" -membertype NoteProperty -Value $ServicesStatus

        $response = Invoke-FreeNasRestMethod -method Put -body $status -Uri $Uri

    }
    End
    {

    }
}
<#
.SYNOPSIS
Shutdown your FreeNas server.
.DESCRIPTION
Shutdown your FreeNas server.
.EXAMPLE
    PS C:\> Stop-FreeNasSystem
#>
function Stop-FreeNasSystem
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    Param( )

    $Uri = "api/v1.0/system/shutdown/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Post

    return $results
}
function Update-FreeNasGlobalConfig
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [Alias()]

    Param
    (
        [Parameter (Mandatory = $false)]
        [String]$Domain,
        [Parameter (Mandatory = $false)]
        [String]$Hostname,
        [Parameter (Mandatory = $false)]
        [String]$Ipv4gateway,
        [Parameter (Mandatory = $false)]
        [String]$Ipv6gateway,
        [Parameter (Mandatory = $false)]
        [String]$Nameserver1,
        [Parameter (Mandatory = $false)]
        [String]$Nameserver2,
        [Parameter (Mandatory = $false)]
        [String]$Nameserver3,
        [Parameter (Mandatory = $false)]
        [String]$Hosts,
        [Parameter (Mandatory = $false)]
        [String]$Proxy

    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/network/globalconfiguration/"

        $Obj = new-Object -TypeName PSObject

        if ( $PsBoundParameters.ContainsKey('Domain') )
        {
            $Obj | add-member -name "gc_domain" -membertype NoteProperty -Value $Domain.ToLower()
        }
        if ( $PsBoundParameters.ContainsKey('Hostname') )
        {
            $Obj | add-member -name "gc_hostname" -membertype NoteProperty -Value $Hostname.ToLower()
        }
        if ( $PsBoundParameters.ContainsKey('Ipv4gateway') )
        {
            $Obj | add-member -name "gc_ipv4gateway" -membertype NoteProperty -Value $Ipv4gateway
        }
        if ( $PsBoundParameters.ContainsKey('Ipv6gateway') )
        {
            $Obj | add-member -name "gc_ipv6gateway" -membertype NoteProperty -Value $Ipv6gateway
        }
        if ( $PsBoundParameters.ContainsKey('Nameserver1') )
        {
            $Obj | add-member -name "gc_nameserver1" -membertype NoteProperty -Value $Nameserver1
        }
        if ( $PsBoundParameters.ContainsKey('Nameserver2') )
        {
            $Obj | add-member -name "gc_nameserver2" -membertype NoteProperty -Value $Nameserver2
        }
        if ( $PsBoundParameters.ContainsKey('Nameserver3') )
        {
            $Obj | add-member -name "gc_nameserver3" -membertype NoteProperty -Value $Nameserver3
        }
        if ( $PsBoundParameters.ContainsKey('Hosts') )
        {
            $Obj | add-member -name "gc_hosts" -membertype NoteProperty -Value $Hosts.ToLower()
        }
        if ( $PsBoundParameters.ContainsKey('Proxy') )
        {
            $Obj | add-member -name "gc_httpproxy" -membertype NoteProperty -Value $Proxy.ToLower()
        }

    }
    End
    {

        $response = Invoke-FreeNasRestMethod -method put -body $Obj -Uri $Uri


    }

}
function Update-FreeNasInterface
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [Alias()]

    Param
    (
        [Parameter (Mandatory = $true)]
        [Int]$Id,
        [Parameter (Mandatory = $true)]
        [String]$Ipv4,
        [Parameter (Mandatory = $true)]
        [ValidateSet("8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30")]
        [String]$NetMask

    )


    Begin
    {

    }
    Process
    {
        $Uri = "api/v1.0/network/interface/$Id/"
        $Obj = new-Object -TypeName PSObject

        Write-Verbose -Message "Detect DHCP status"
        $Dhcp = Get-FreeNasInterface

        switch ($Dhcp.Dhcp)
        {
            'True'
            {
                $Obj | add-member -name "int_dhcp" -membertype NoteProperty -Value $false
                $Obj | add-member -name "int_ipv4address" -membertype NoteProperty -Value $Ipv4.ToLower()
                $Obj | add-member -name "int_v4netmaskbit" -membertype NoteProperty -Value $NetMask.ToLower()
            }

            'False'
            {
                $Obj | add-member -name "int_ipv4address" -membertype NoteProperty -Value $Ipv4.ToLower()
                $Obj | add-member -name "int_v4netmaskbit" -membertype NoteProperty -Value $NetMask.ToLower()

            }
            Default { }
        }




    }
    End
    {

        $response = Invoke-FreeNasRestMethod -method Put -body $Obj -Uri $Uri
        Write-Warning "You need to reconnect to the host $Ipv4/$NetMask"

    }

}
function Update-FreeNasSetting
{
    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    Param
    (
        [Parameter (Mandatory = $true)]
        [string]$Id,

        [Parameter (Mandatory = $false)]
        [String]$GuiPort,

        [Parameter (Mandatory = $false)]
        [String]$GuiHttpsPort,

        [Parameter (Mandatory = $false)]
        [ValidateSet("true", "false")]
        [String]$GuiHttpsredirect,


        [Parameter (Mandatory = $false)]
        [ValidateSet("http", "httphttps", "https")]
        [String]$GuiProtocol,

        [Parameter (Mandatory = $false)]
        [String]$Guiv6Address = "::",

        [Parameter (Mandatory = $false)]
        [ipaddress]$Syslogserver,

        [Parameter (Mandatory = $false)]
        [String]$Language,

        [Parameter (Mandatory = $false)]
        [String]$Directoryservices,

        [Parameter (Mandatory = $false)]
        [String]$GuiAddress,

        [Parameter (Mandatory = $false)]
        [Int]$GuiCertifiacteId

    )


    Begin
    { }
    Process
    {
        $Uri = "api/v1.0/system/settings/"

        $Obj = new-Object -TypeName PSObject

        $Obj | add-member -name "id" -membertype NoteProperty -Value $Id

        if ( $PsBoundParameters.ContainsKey('GuiPort') )
        {

            $Obj | add-member -name "stg_guiport" -membertype NoteProperty -Value $GuiPort
        }
        if ( $PsBoundParameters.ContainsKey('GuiHttpsPort') )
        {

            $Obj | add-member -name "stg_guihttpsport" -membertype NoteProperty -Value $GuiHttpsPort
        }
        if ( $PsBoundParameters.ContainsKey('GuiHttpsredirect') )
        {

            $Obj | add-member -name "stg_guihttpsredirect" -membertype NoteProperty -Value $GuiHttpsredirect
        }
        if ( $PsBoundParameters.ContainsKey('GuiProtocol') )
        {

            $Obj | add-member -name "stg_guiprotocol" -membertype NoteProperty -Value $GuiProtocol
        }
        if ( $PsBoundParameters.ContainsKey('Guiv6Address') )
        {

            $Obj | add-member -name "stg_guiv6address" -membertype NoteProperty -Value $Guiv6Address
        }
        if ( $PsBoundParameters.ContainsKey('Syslogserver') )
        {

            $Obj | add-member -name "stg_syslogserver" -membertype NoteProperty -Value $Syslogserver
        }
        if ( $PsBoundParameters.ContainsKey('Language') )
        {

            $Obj | add-member -name "stg_language" -membertype NoteProperty -Value $Language
        }
        if ( $PsBoundParameters.ContainsKey('Directoryservices') )
        {

            $Obj | add-member -name "stg_directoryservice" -membertype NoteProperty -Value $Directoryservices
        }
        if ( $PsBoundParameters.ContainsKey('GuiAddress') )
        {

            $Obj | add-member -name "stg_guiaddress" -membertype NoteProperty -Value $GuiAddress
        }
        if ( $PsBoundParameters.ContainsKey('GuiCertifiacteId') )
        {

            $Obj | add-member -name "stg_guicertificate" -membertype NoteProperty -Value $GuiCertifiacteId
        }

        if ($PSCmdlet.ShouldProcess( "We are update FreeNas system "))
        {
            $response = Invoke-FreeNasRestMethod -method PUT -body $Obj -Uri $Uri
        }
    }
    End
    { }
}
<#
.SYNOPSIS
Update your FreeNas Server
.DESCRIPTION
This function download all available update for your system and perform update
.EXAMPLE
    PS C:\> Update-FreeNasSystem
#>
function Update-FreeNasSystem
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    Param( )

    $Uri = "api/v1.0/system/update/update/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Post

    return $results
}
#######################################

Connect-FreeNasServer 192.168.0.26 -httpOnly

<#
.SYNOPSIS
This function Users informations about your FreeNas server.
.DESCRIPTION
This function Users informations about your FreeNas server.
.EXAMPLE
    PS C:\> Get-FreeNasUser

    Id                : 1
    Username          : root
    Full_name         : root
    Email             : 
    Shell             : /usr/local/bin/zsh
    Home              : /root
    Locked_user       : False
    Password_disabled : False
    Uid               : 0
    Builtin           : True
    Group             : 1
    Sudo              : False
    Ssh_pub_Key       : 

    Id                : 2
    Username          : daemon
    Full_name         : Owner of many system processes
    Email             : 
    Shell             : /usr/sbin/nologin
    Home              : /root
    Locked_user       : False
    Password_disabled : False
    Uid               : 1
    Builtin           : True
    Group             : 2
    Sudo              : False
    Ssh_pub_Key       : 

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Get-FreeNasUser {
    Param( )

    $Uri = "api/v1.0/account/users/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    foreach ($Info in $results) {
        [PSCustomObject]@{
            Id               = ($Info.id)
            Username         = ($Info.bsdusr_username )
            Full_name        = ($Info.bsdusr_full_name)
            Email            = ($Info.bsdusr_email)
            Shell            = ($Info.bsdusr_shell)
            Home             = ($Info.bsdusr_home)
            Locked_user      = ($Info.bsdusr_locked)
            Password_disabled= ($Info.bsdusr_password_disabled)
            Uid              = ($Info.bsdusr_uid)
            Builtin          = ($Info.bsdusr_builtin)
            Group            = ($Info.bsdusr_group)
            Sudo             = ($Info.bsdusr_sudo)
            Ssh_pub_Key      = ($Info.bsdusr_sshpubkey)
        }
    }
}

<#
.SYNOPSIS
This function Groups informations about your FreeNas server.
.DESCRIPTION
This function Groups informations about your FreeNas server.
.EXAMPLE
    PS C:\> Get-FreeNasGroup

    Id       : 1
    Builtin  : True
    Group    : wheel
    Group_Id : 0
    Sudo     : False

    Id       : 2
    Builtin  : True
    Group    : daemon
    Group_Id : 1
    Sudo     : False

    Id       : 3
    Builtin  : True
    Group    : kmem
    Group_Id : 2
    Sudo     : False

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Get-FreeNasGroup {
    Param( )

    $Uri = "api/v1.0/account/groups/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    foreach ($Info in $results) {
        [PSCustomObject]@{
            Id               = ($Info.id)
            Builtin          = ($Info.bsdgrp_builtin)
            Group            = ($Info.bsdgrp_group)
            Group_Id         = ($Info.bsdgrp_gid)
            Sudo             = ($Info.bsdgrp_sudo)
        }
    }
    
}

<#
.SYNOPSIS
This function remove Users from FreeNas server.
.DESCRIPTION
This function remove Users from FreeNas server.
.EXAMPLE
    PS C:\> Get-FreeNasUserById -Id 1 


.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-FreeNasUserById {

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    Param(
            [Parameter (Mandatory = $true)]
            [string]$Id
 )

    $Uri = "api/v1.0/account/users/$Id/"


            if ($PSCmdlet.ShouldProcess( "We are delete de User with the Id $Id "))
        {
            $response = Invoke-FreeNasRestMethod -Uri $Uri -Method DELETE
        }

    Write-Warning -Message "The user with the Id $Id have be removed"

}

<#
.SYNOPSIS
This function remove groups from FreeNas server.
.DESCRIPTION
This function remove groups from FreeNas server.
.EXAMPLE
    PS C:\> Get-FreeNasGroupById -Id 1 


.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Remove-FreeNasGroupById {

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    Param(
            [Parameter (Mandatory = $true)]
            [string]$Id
 )

    $Uri = "api/v1.0/account/groups/$Id/"


            if ($PSCmdlet.ShouldProcess( "We are delete de Group with the Id $Id "))
        {
            $response = Invoke-FreeNasRestMethod -Uri $Uri -Method DELETE
        }

    Write-Warning -Message "The Group with the Id $Id have be removed"

}

<#
.SYNOPSIS
This function find All Dataset informations for your FreeNas server.
.DESCRIPTION
This function find All Dataset informations for your FreeNas server.
.EXAMPLE
    PS C:\> Get-FreeNasDatasets

    Access_time        : on
    Space_available_GB : 53.27
    Comments           : 
    Compression        : lz4
    Deduplication      : off
    Mount_point        : /mnt/Stripe
    Name               : Stripe
    Pool               : Stripe
    Quota              : 0
    Readonly           : off
    Recordsize         : 131072
    Reference          : 
    Space_used_GB      : 0.01

    Access_time        : on
    Space_available_GB : 53.27
    Comments           : 
    Compression        : lz4
    Deduplication      : off
    Mount_point        : legacy
    Name               : Stripe/.system
    Pool               : Stripe
    Quota              : 0
    Readonly           : off
    Recordsize         : 131072
    Reference          : 
    Space_used_GB      : 0.01

.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
function Get-FreeNasDatasets {
    Param( )

    $Uri = "api/v1.0/storage/dataset/"

    $results = Invoke-FreeNasRestMethod -Uri $Uri -Method Get

    foreach ($Info in $results) {
        [PSCustomObject]@{
            Access_time               = ($Info.atime)
            Space_available_GB        = ([Math]::Round($Info.avail /1024/1024/1024,2))
            Comments                  = ($Info.comments)
            Compression               = ($Info.compression)
            Deduplication             = ($Info.dedup)
            Mount_point               = ($Info.mountpoint)
            Name                      = ($Info.name)
            Pool                      = ($Info.pool)
            Quota                     = ($Info.quota)
            Readonly                  = ($Info.readonly)
            Recordsize                = ($Info.Recordsize)
            Reference                 = ($Info.reference)
            Space_used_GB             = ([Math]::Round($Info.used /1024/1024/1024,2))

        }
    }
}

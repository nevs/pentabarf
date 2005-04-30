all: clean wget conv pdf 

clean:
	rm -f *.tu* *.tmp *.log *.mp fahrplan.ics day?data.tex

mrproper:
	rm -f *.pdf

wget:
	wget -O fahrplan.ics http://www.ccc.de/congress/2004/fahrplan/fahrplan.ics
	
conv:
	./ical2tex.pl
	
pdf:
	texexec --pdf day1.tex
	texexec --pdf day2.tex
	texexec --pdf day3.tex

scp:
	scp day*.pdf alech@dach-wg.de:/var/www/www.alech.de/tmp/


main.css: main.template $(filter-out main.css,$(wildcard *.css))
		cat main.template | sed -e 's!.*"\(.*\)".*!\1!' | xargs cat > main.css


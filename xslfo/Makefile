# Customize this:
DOCUMENT				?=	guide.xml
EXPORTPATH			?=	../../22C3
FOP_PROCESSOR		?=	~/programs/fop/fop


# Customize this if in doubt:
XSLT_PROCESSOR	?=	xsltproc


# Automatic definitions:
DOCUMENT_FO=$(patsubst %.xml, %.fo, $(DOCUMENT))
DOCUMENT_PDF=$(patsubst %.xml, %.pdf, $(DOCUMENT))


# Constants:

XSL_STYLESHEET=xslfo.xsl


# Rules:

$(DOCUMENT_FO): $(DOCUMENT) $(XSL_STYLESHEET)
	$(XSLT_PROCESSOR) --stringparam exportpath $(EXPORTPATH) $(XSL_STYLESHEET) $(DOCUMENT) > $@

$(DOCUMENT_PDF): $(DOCUMENT_FO)
	$(FOP_PROCESSOR) -fo $(DOCUMENT_FO) -pdf $@

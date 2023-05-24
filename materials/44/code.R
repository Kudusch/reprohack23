library(spacyr)
library(rsyntax)

tokens = spacy_parse("Trump said that Biden is the dumbest of all candidates", dependency=T)
plot_tree(tokens)

speech_verbs = c("say", "state") ## etc.
source_said = tquery(pos = "VERB", lemma = speech_verbs)

source_said = tquery(pos = "VERB", lemma = speech_verbs,
                     children(relation = "nsubj"))

source_said = tquery(label = "quote", pos = "VERB", lemma = 
speech_verbs,
    children(label = "source", relation = "nsubj"),
children(label = "quote"))

tokens = annotate_tqueries(tokens, "verb", source_said)

plot_tree(tokens, annotation="quote")

according_to_source = tquery(label = "quote", pos = "VERB",
    children(label = "verb", lemma="accord",
        children(lemma = "to",
                 children(label = "source"))))

chain = list(source_said, according_to_source)
tokens = annotate_tqueries(tokens, "quote", chain)

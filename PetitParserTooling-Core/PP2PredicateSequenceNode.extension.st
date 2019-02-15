Extension { #name : #PP2PredicateSequenceNode }

{ #category : #'*PetitParserTooling-Core' }
PP2PredicateSequenceNode >> acceptVisitor: aVisitor [ 
	^ aVisitor visitPP2PredicateSequenceNode: self
]

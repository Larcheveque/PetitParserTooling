Extension { #name : #PP2ChoiceNode }

{ #category : #'*PetitParserTooling-Core' }
PP2ChoiceNode >> acceptVisitor: aVisitor [ 
	^ aVisitor visitPP2ChoiceNode: self
]

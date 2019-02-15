Extension { #name : #PP2NotNode }

{ #category : #'*PetitParserTooling-Core' }
PP2NotNode >> acceptVisitor: aVisitor [ 
	^ aVisitor visitPP2NotNode: self
]

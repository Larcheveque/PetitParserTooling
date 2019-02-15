Extension { #name : #PP2OptionalNode }

{ #category : #'*PetitParserTooling-Core' }
PP2OptionalNode >> acceptVisitor: aVisitor [ 
	^ aVisitor visitPP2OptionalNode: self
]

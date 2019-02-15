Extension { #name : #PP2SequenceNode }

{ #category : #'*PetitParserTooling-Core' }
PP2SequenceNode >> acceptVisitor: aVisitor [ 
	^ aVisitor visitPP2SequenceNode: self
]

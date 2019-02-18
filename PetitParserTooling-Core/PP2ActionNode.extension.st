Extension { #name : #PP2ActionNode }

{ #category : #'*PetitParserTooling-Core' }
PP2ActionNode >> acceptVisitor: aVisitor [
	^ aVisitor visitPP2ActionNode: self
]

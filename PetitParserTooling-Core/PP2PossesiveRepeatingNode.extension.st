Extension { #name : #PP2PossesiveRepeatingNode }

{ #category : #'*PetitParserTooling-Core' }
PP2PossesiveRepeatingNode >> acceptVisitor: aVisitor [
	^ aVisitor visitPP2PossesiveRepeatingNode: self
]

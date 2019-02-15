Extension { #name : #PP2DelegateNode }

{ #category : #'*PetitParserTooling-Core' }
PP2DelegateNode >> acceptVisitor: aVisitor [
	self class = PP2DelegateNode
		ifFalse: [ self subclassResponsibility ].
	^ aVisitor visitPP2DelegateNode: self
]

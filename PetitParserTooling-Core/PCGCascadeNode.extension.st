Extension { #name : #PCGCascadeNode }

{ #category : #'*PetitParserTooling-Core' }
PCGCascadeNode >> receiveFirstMessage: aSymbol with: argument if: conditionBlock [
	conditionBlock value
		ifFalse: [ ^ self ].
	^ self messages
		addFirst:
			(PCGMessageNode
				receiver: self target
				selector: aSymbol
				arguments: {argument})
]

Class {
	#name : #PPTCodeCollect,
	#superclass : #PPTCode,
	#instVars : [
		'subProductionCode',
		'receiver',
		'position'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTCodeCollect class >> receiver: aReceiverPPTCode subProduction: aPPTCodeSubProduction code: aPPTCode [
	^ self new
		receiver: aReceiverPPTCode;
		code: aPPTCode;
		subProductionCode: aPPTCodeSubProduction;
		yourself
]

{ #category : #'attribute management' }
PPTCodeCollect >> allAssignations [
	^ self receiver allAssignations 
]

{ #category : #pcg }
PPTCodeCollect >> obtainPCGNode [
	| receiverNode |
	receiverNode := self receiver obtainPCGNode.
	receiverNode
		arguments:
			{(PCGMessageNode
				receiver: receiverNode arguments first
				selector: #collect:
				arguments:
					{(PCGBlockNode
						arguments: {self subProductionCode obtainPCGNode}
						body:
							(PCGSequenceNode
								statements:
									(PCGMessageNode
										receiver: self subProductionCode obtainPCGNode
										selector: #at:
										arguments: self position asPCG)))})}.
	^ receiverNode
]

{ #category : #accessing }
PPTCodeCollect >> position [
	^ position
]

{ #category : #accessing }
PPTCodeCollect >> position: anObject [
	position := anObject
]

{ #category : #accessing }
PPTCodeCollect >> receiver [
	^ receiver
]

{ #category : #accessing }
PPTCodeCollect >> receiver: anObject [
	receiver := anObject
]

{ #category : #accessing }
PPTCodeCollect >> subProductionCode [
	^ subProductionCode
]

{ #category : #accessing }
PPTCodeCollect >> subProductionCode: anObject [
	subProductionCode := anObject
]

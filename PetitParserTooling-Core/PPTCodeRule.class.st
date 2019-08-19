"
I represent the rule in PPTCode. I am the root level and i am able to produce directly the code to compile
"
Class {
	#name : #PPTCodeRule,
	#superclass : #PPTCode,
	#instVars : [
		'ruleName',
		'nodeName',
		'productionNode',
		'keepPositions'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'attribute management' }
PPTCodeRule >> allAssignations [
	^ self productionNode allAssignations
]

{ #category : #accessing }
PPTCodeRule >> keepPositions [
	^ keepPositions
]

{ #category : #accessing }
PPTCodeRule >> keepPositions: anObject [
	keepPositions := anObject
]

{ #category : #accessing }
PPTCodeRule >> nodeName [
	^ nodeName
]

{ #category : #accessing }
PPTCodeRule >> nodeName: anObject [
	nodeName := anObject
]

{ #category : #pcg }
PPTCodeRule >> obtainPCGNode [
	^ (PCGMethodNode selector: self ruleName)
		bodyBlock: [ :body | 
			body
				<<
					(((#super asPCGNode receiveMessage: self ruleName)
						receiveMessage: #withPositions
						if: self keepPositions)
						receiveMessage: #==>
						with:
							((PCGBlockNode arguments: {#production asPCGArgument})
								bodyBlock: [ :body1 | 
									body1
										<<
											(self productionNode obtainCascadePCGNode
												target: (self nodeName asPCGGlobal receiveMessage: #new);
												receiveFirstMessage: #stopPosition:
													with: (#production asPCGArgument receiveMessage: #stop)
													if: self keepPositions;
												receiveFirstMessage: #startPosition:
													with: (#production asPCGArgument receiveMessage: #start)
													if: self keepPositions;
												receiveMessage: #yourself;
												yourself) ])) returnIt ];
		protocol: #rules;
		yourself
]

{ #category : #accessing }
PPTCodeRule >> productionNode [
	^ productionNode
]

{ #category : #accessing }
PPTCodeRule >> productionNode: anObject [
	productionNode := anObject
]

{ #category : #accessing }
PPTCodeRule >> ruleName [
	^ ruleName
]

{ #category : #accessing }
PPTCodeRule >> ruleName: anObject [
	ruleName := anObject
]

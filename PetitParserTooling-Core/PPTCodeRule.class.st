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
		'instanceCreationOptionNodes',
		'keepPositions'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #accessing }
PPTCodeRule >> instanceCreationOptionNodes [
	^ instanceCreationOptionNodes
]

{ #category : #accessing }
PPTCodeRule >> instanceCreationOptionNodes: anObject [
	instanceCreationOptionNodes := anObject
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
					((#super asPCGNode receiveMessage: self ruleName)
						receiveMessage: #==>
						with:
							((PCGBlockNode arguments: {#production asPCGArgument})
								bodyBlock: [ :body1 | 
									body1
										<<
											(self productionNode obtainCascadePCGNode
												target: (self nodeName asPCGGlobal receiveMessage: #new);
												receiveMessage: #yourself;
												yourself)
									"receiveMessage: #startPosition:
												with: (#production asPCGArgument receiveMessage: #start);
											receiveMessage: #stopPosition:
												with: (#production asPCGArgument receiveMessage: #stop);
											receiveMessage: #content:
												with: (#production asPCGArgument receiveMessage: #content);" ]))
						returnIt
			"receiveMessage: #withPositions if: keepPositions" ];
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

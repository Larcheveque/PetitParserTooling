Class {
	#name : #PPTRuleCollectsWithPositions,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'rules'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #accessing }
PPTRuleCollectsWithPositions class >> rules: aCollectionOfRules [
	^ self new
		rules: aCollectionOfRules;
		yourself
]

{ #category : #'as yet unclassified' }
PPTRuleCollectsWithPositions >> attributesToCreate [
	^ self rules flatCollect: #attributesToCreate
]

{ #category : #serialization }
PPTRuleCollectsWithPositions >> obtainCodeRepresentation: aPPTCode [ 
	^ PPTCodeCascade
		codes:
			(self rules
				collect:
					[ :aCollectRule | aCollectRule obtainCodeRepresentation: aPPTCode ])
]

{ #category : #accessing }
PPTRuleCollectsWithPositions >> rules [
	^ rules
]

{ #category : #accessing }
PPTRuleCollectsWithPositions >> rules: anObject [
	rules := anObject
]

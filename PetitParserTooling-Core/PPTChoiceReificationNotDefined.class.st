"
When a choice (/) is defined in a parser rule, it must be resolved to know how to name the ast node.

example: <reify: #( parametrizedType / basicType / customType ) into: #type>
"
Class {
	#name : #PPTChoiceReificationNotDefined,
	#superclass : #Error,
	#instVars : [
		'rulesCombination',
		'rule',
		'contextNode'
	],
	#category : #'PetitParserTooling-Core-Exceptions'
}

{ #category : #accessing }
PPTChoiceReificationNotDefined >> contextNode [
	^ contextNode
]

{ #category : #accessing }
PPTChoiceReificationNotDefined >> contextNode: anObject [
	contextNode := anObject
]

{ #category : #accessing }
PPTChoiceReificationNotDefined >> messageText [
	^ '#' , self rule , ' - {' , self rulesCombination asString
		,
			' - You should define a pragma in your rule to express how the multiple choice (/) should be named in a unique name'
]

{ #category : #accessing }
PPTChoiceReificationNotDefined >> rule [
	^ rule
]

{ #category : #accessing }
PPTChoiceReificationNotDefined >> rule: anObject [
	rule := anObject
]

{ #category : #accessing }
PPTChoiceReificationNotDefined >> rulesCombination [
	^ rulesCombination
]

{ #category : #accessing }
PPTChoiceReificationNotDefined >> rulesCombination: anObject [
	rulesCombination := anObject
]

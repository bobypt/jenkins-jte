@AfterStep
void call(context){
    println 'Notify ===============================><<<>>>' + context.step
    context.properties.each { println "$it.key -> $it.value" }
}
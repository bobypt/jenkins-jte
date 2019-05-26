@AfterStep
void call(context){
    println 'Notify ===============================><<<>>>' + context.step + " Status:: " + context.status
    context.properties.each { println "$it.key -> $it.value" }
}
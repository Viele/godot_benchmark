extends ItemList

var _results: Array[BenchmarkResult]


func _ready():
    item_selected.connect(_item_selected)


func _item_selected(_index: int):
    var selected_results: Array[BenchmarkResult] = []
    for index in get_selected_items():
        selected_results.append(_results[index])
    $%graph.draw_results(selected_results)


func load(results: Array[BenchmarkResult]):
    _results = results
    clear()
    for result in results:
        add_item(result.name)

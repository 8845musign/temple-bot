module.exports = (robot) ->
  robot.brain.on 'loaded', () ->

  KEY_LIST = 'increment-list2'
  robot.hear /.*\+\+$/i, (msg) ->
    name = msg.match[0].replace('++', '').trim()
    # インクリメント
    list = robot.brain.get(KEY_LIST) ? []

    list.push name
    robot.brain.set KEY_LIST, list

    robot.brain.save()

    # 取得
    point = list.filter((item) -> item == name).length
    msg.send name + 'さんすごい（' + point + 'pt）'

  robot.respond /リスト/i, (msg) ->
    list = robot.brain.get(KEY_LIST) ? []

    sum = {}
    for val in list
      sum[val] = if sum[val] then ++sum[val] else 1

    r = '';
    for key, val of sum
      r = r + '\n' + key + 'さん（' + sum[key] + 'pt）'
    msg.send if r then r else '誰もいません'

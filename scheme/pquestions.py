def list_change(total, denoms):
    def help(total, denoms, now):
        if not denoms:
            return []
        elif total == 0:
            return [now]

        elif denoms[0] > total:
            return help(total, denoms[1:], now)
        else:
            return help(total-denoms[0], denoms, now + [denoms[0]]) + help(total, denoms[1:], now)
    return help(total, denoms, [])

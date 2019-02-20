import xml.etree.ElementTree as ET

def parse_xml_input(filepath):
    """
    Parse input xml file containing TSP (Traveling Salesman Problem) data
    :param filespath: path to the file
    :return: cost matrix
    """
    tree = ET.parse(filepath)
    root = tree.getroot()
    graph_root = root.find('graph')

    answer = []
    n = len(graph_root)
    for i, vertex in enumerate(graph_root):
        answer.append([0 for x in range(n)])
        for edge in vertex:
            j = int(edge.text)
            cost = float(edge.attrib['cost'])
            answer[i][j] = cost

    c = 0
    for i in range(n):
        for j in range(n):
            print(answer[i][j], end=' ')
        print()
    return answer


parse_xml_input('/Users/d40a/Downloads/ftv64.xml')
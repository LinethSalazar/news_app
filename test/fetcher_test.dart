import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_assigment_1/news/model/fetcher/online_news_gen.dart';
import 'package:fake_assigment_1/news/model/news_item.dart';
import 'fetcher_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
String fakefeed = '''
<?xml version="1.0" encoding="utf-8"?>
<rss xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:og="http://ogp.me/ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:schema="http://schema.org/" xmlns:sioc="http://rdfs.org/sioc/ns#" xmlns:sioct="http://rdfs.org/sioc/types#" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#" version="2.0" xml:base="https://www.upei.ca/">
  <channel>
    <title>Media Releases</title>
    <link>https://www.upei.ca/</link>
    <description/>
    <language>en</language>
    
    <item>
  <title>Tentative agreement reached with IBEW 1928</title>
  <link>https://www.upei.ca/communications/news/2026/03/tentative-agreement-reached-ibew-1928</link>
  <description>&lt;p&gt;&lt;em&gt;The following statement was also emailed to UPEI faculty and staff on March 11.&lt;/em&gt;&lt;/p&gt;&lt;p&gt;After a day and a half of bargaining earlier this week, UPEI has reached a tentative agreement with the International Brotherhood of Electrical Workers (IBEW 1928). The tentative agreement is subject to ratification by both parties.&lt;/p&gt;&lt;p&gt;We appreciate the dedication and professionalism of both bargaining teams in their work to reach a timely agreement, and the respectful and constructive manner in which they approached the negotiations.&lt;/p&gt;&lt;p&gt;Guided by UPEI’s core values and bargaining principles, we remain committed to fostering a respectful, inclusive, and supportive environment for all members of our campus community and look forward to continuing our work together. Details on our approach and agreements can be found on our website: &lt;a href="https://www.upei.ca/labour/collective-bargaining"&gt;Collective Bargaining&lt;/a&gt;.&lt;/p&gt;&lt;p&gt;&lt;a href="https://www.upei.ca/labour/updates"&gt;Updates&lt;/a&gt; will continue to be shared with the UPEI community as the ratification process moves forward.&lt;/p&gt;</description>
  <pubDate>Wed, 11 Mar 2026 08:41:51 -0300</pubDate>
    <dc:creator>Nicole Phillips</dc:creator>
    <guid isPermaLink="true">https://www.upei.ca/communications/news/2026/03/tentative-agreement-reached-ibew-1928</guid>
    </item>
  </channel>
</rss>
''';
  String fakefeed2 = '''

<?xml version="1.0" encoding="UTF-8"?>
        <rss version="2.0">
         <channel>
          <title>UPEI News</title>
            <item>
              <title>Fake News Title One</title>
              <link>https://upei.ca/news/1</link>
              <description>This is the fake body of the article</description>
              <pubDate>Mon, 01 Jan 2024 00:00:00 GMT</pubDate>
              <dc:creator>John Doe</dc:creator>
            </item>
            <item>
              <title>Fake News Title Two</title>
              <link>https://upei.ca/news/2</link>
              <description>This is the fake body of the article</description>
              <pubDate>Mon, 01 Jan 2024 00:00:00 GMT</pubDate>
              <dc:creator>Jane Smith</dc:creator>
            </item>
          </channel>
        </rss>

''';
  late MockClient mockClient;
  late OnlineNewsGen newsGen;
  group("testing the Online fetcher", () {
    
    setUp(() {
      mockClient = MockClient();
      newsGen = OnlineNewsGen(client: mockClient);
      when(mockClient.get(Uri.parse('https://www.upei.ca/feeds/news.rss')),
      ).thenAnswer(
        (_) async => http.Response(fakefeed2, 200),
      );
      });

      test("get the list of news items", () async {
        final newsItems = await newsGen.getNews();
        expect(newsItems.length, 2);
        expect(newsItems[0].title, 'Fake News Title One');
        expect(newsItems[0].body, 'This is the fake body of the article');
        expect(newsItems[0].date, DateTime.parse('2024-01-01T00:00:00'));
        expect(newsItems[0].author, 'John Doe');

        expect(newsItems[1].title, 'Fake News Title Two');
        expect(newsItems[1].body, 'This is the fake body of the article');
        expect(newsItems[1].date, DateTime.parse('2024-01-01T00:00:00'));
        expect(newsItems[1].author, 'Jane Smith');

      });  
  });
  group("Online fetcher with feed 1", () {
    setUp(() {
      mockClient = MockClient();
      newsGen = OnlineNewsGen(client: mockClient);
      when(
        mockClient.get(Uri.parse('https://www.upei.ca/feeds/news.rss')),
      ).thenAnswer(
        (_) async => http.Response.bytes(
          utf8.encode(fakefeed), 
          200,
          headers: {'content-type': 'application/rss+xml; charset=utf-8'},
        ),
      );
      });

      test("get the list of news items", () async {
        final newsItems = await newsGen.getNews();
        expect(newsItems.length, 1);
        expect(newsItems[0].title, 'Tentative agreement reached with IBEW 1928');
        expect(newsItems[0].body, 'The following statement was also emailed to UPEI faculty and staff on March 11.After a day and a half of bargaining earlier this week, UPEI has reached a tentative agreement with the International Brotherhood of Electrical Workers (IBEW 1928). The tentative agreement is subject to ratification by both parties.We appreciate the dedication and professionalism of both bargaining teams in their work to reach a timely agreement, and the respectful and constructive manner in which they approached the negotiations.Guided by UPEI’s core values and bargaining principles, we remain committed to fostering a respectful, inclusive, and supportive environment for all members of our campus community and look forward to continuing our work together. Details on our approach and agreements can be found on our website: Collective Bargaining.Updates will continue to be shared with the UPEI community as the ratification process moves forward.');
        expect(newsItems[0].date, DateTime.parse('2026-03-11T08:41:51'));
        expect(newsItems[0].author, 'Nicole Phillips');
        
    });  
  });

  
}
  
  
  


  

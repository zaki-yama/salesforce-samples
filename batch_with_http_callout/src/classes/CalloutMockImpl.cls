/**
 * モッククラス
 */
@isTest
global class CalloutMockImpl implements HttpCalloutMock {

	global HttpResponse respond(HttpRequest req) {

		System.assertEquals('POST', req.getMethod());

		HttpResponse res = new HttpResponse();
		res.setHeader('Content-type', 'application/json');
		res.setStatusCode(201);
		res.setStatus('Created');
		res.setBody('{"foo": "bar"}');

		return res;
	}
}
